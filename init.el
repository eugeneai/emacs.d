;;; Configuration --- Summary
;;; Commentary:
;; Modern Emacs configuration for 2024-2025
;;; Code:
;; init.el --- Emacs configuration

;; ============================================================================
;; Basic Setup and Performance
;; ============================================================================

;; Increase garbage collection threshold for better performance
(setq gc-cons-threshold (* 50 1024 1024))  ; 50MB
(setq read-process-output-max (* 1024 1024)) ; 1MB

;; Disable lockfiles for better npm/Node.js compatibility
(setq create-lockfiles nil)

;; Set default coding system
(setq default-buffer-file-coding-system 'utf-8)

;; ============================================================================
;; UI/UX Cleanup
;; ============================================================================

;; Remove UI chrome for a cleaner look
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(setq inhibit-startup-screen t)

;; Configure display buffer behavior
(add-to-list 'display-buffer-alist
             '("." nil (reusable-frames . t)))

;; User information
(setq user-full-name "Evgeny Cherkashin"
      user-mail-address "eugeneai@irnok.net")

;; ============================================================================
;; Package Management
;; ============================================================================

(defun enable-proxy-for-packages ()
  "Временно включить proxy для установки пакетов."
  (interactive)
(setq url-proxy-services '(("no_proxy" . "127\\.0\\.0\\.1")
                           ("http" . "192.168.191.201:3128")
                           ("https" . "192.168.191.201:3128")
                           ("ftp" . "192.168.191.201:3128")))
  (message "Proxy включен для установки пакетов"))

(defun disable-proxy-after-packages ()
  "Отключить proxy после установки пакетов."
  (interactive)
  (setq url-proxy-services nil)
  (message "Proxy отключен"))

(enable-proxy-for-packages)

;; Initialize package system
(require 'package)

;; Configure package archives with SSL support
;; (let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
;;                     (not (gnutls-available-p))))
;;        (proto (if no-ssl "http" "https")))
;;   (add-to-list 'package-archives (cons "melpa" (concat proto "://stable.melpa.org/packages/")) t)
;; ;;  (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")) t)
;;   (add-to-list 'package-archives (cons "elpy" (concat proto "://jorgenschaefer.github.io/packages/")) t))

(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("melpa-stable" . "https://stable.melpa.org/packages/")
        ("gnu" . "https://elpa.gnu.org/packages/")
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")))

;; Настроить приоритет репозиториев
(setq package-archive-priorities
      '(("gnu" . 10)
        ("melpa-stable" . 5)
        ("melpa" . 0)))

(package-initialize)

;; Refresh package contents if needed
(unless (file-exists-p "~/.emacs.d/elpa/archives/melpa")
  (package-refresh-contents))

;; Bootstrap use-package
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(unless (package-installed-p 'diminish)
  (package-install 'diminish))

(require 'use-package)
(setq use-package-always-ensure t)
(setq use-package-verbose t)

;; ============================================================================
;; Core Editing Enhancements
;; ============================================================================

(use-package better-defaults
  :config
  ;; Use 'y' or 'n' instead of 'yes' or 'no'
  (defalias 'yes-or-no-p 'y-or-n-p)
  (setq org-confirm-elisp-link-function 'y-or-n-p)

  ;; Visual improvements
  (show-paren-mode t)
  (setq show-paren-style 'expression)
  (delete-selection-mode t)
  (setq column-number-mode t)
  (display-time-mode t)
  (setq visible-bell t)
  (setq sentence-end-double-space t)
  (setq scroll-step 1))

;; Line numbers
(if (version< emacs-version "26.0.50")
    (use-package nlinum
      :bind ("C-`" . nlinum-mode))
  (global-set-key (kbd "C-`") 'display-line-numbers-mode))

;; Window navigation
(when (fboundp 'windmove-default-keybindings)
  (global-set-key (kbd "C-c <left>")  'windmove-left)
  (global-set-key (kbd "C-c <right>") 'windmove-right)
  (global-set-key (kbd "C-c <up>")    'windmove-up)
  (global-set-key (kbd "C-c <down>")  'windmove-down))

;; Buffer management
(global-set-key (kbd "C-x C-b") 'buffer-menu)
(global-set-key (kbd "C-x C-k") 'kill-current-buffer)

;; File management
(global-set-key (kbd "C-x C-j") 'dired-at-point)

;; ============================================================================
;; Modern Completion and Navigation
;; ============================================================================

;; Vertico - modern minibuffer completion
(use-package vertico
  :init
  (vertico-mode)
  :config
  (setq vertico-count 20
        vertico-resize t
        vertico-cycle t))

;; Orderless - flexible completion style
(use-package orderless
  :init
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))

;; Marginalia - rich annotations in minibuffer
(use-package marginalia
  :init
  (marginalia-mode))

;; Consult - useful search and navigation commands
(use-package consult
  :bind
  (("C-s" . consult-line)
   ;; ("C-M-l" . consult-buffer)
   ("M-I" . consult-imenu)
   ("C-x b" . consult-buffer)
   ("C-x C-b" . consult-buffer)
   ("M-y" . consult-yank-pop)
   ("M-g g" . consult-goto-line)
   ("M-g M-g" . consult-goto-line)
   ("M-RET s r" . consult-ripgrep)
   ("M-RET s g" . consult-git-grep)
   :map minibuffer-local-map
   ("C-r" . consult-history))
  :config
  ;; ⚡ ОПТИМИЗАЦИИ ДЛЯ СКОРОСТИ ⚡
  (setq consult-preview-key nil          ; Отключить preview
        consult-async-input-debounce 0.1 ; Дебаунс ввода
        consult-async-input-throttle 0.2 ; Троттлинг
        consult-narrow-key "<"           ; Быстрое сужение
        )
  ;; Минимальная команда rg
  (setq consult-ripgrep-command
        "rg --null --line-buffered --color=never --max-columns=500 --smart-case --no-heading --line-number . ")
  )

;; Embark - contextual actions
(use-package embark
  :bind
  (("C-." . embark-act)
   ("C-;" . embark-dwim)
   ("M-." . embark-act))
  :init
  (setq prefix-help-command #'embark-prefix-help-command))

(use-package embark-consult
  :after (embark consult)
  :demand t)

;; ============================================================================
;; Language Server Protocol (LSP)
;; ============================================================================

(use-package eglot
  :hook ((python-mode js-mode js2-mode typescript-mode haskell-mode latex-mode) . eglot-ensure)
  :config
  (setq eglot-autoshutdown t
        eglot-send-changes-idle-time 0.5
        eglot-connect-timeout 10)

  ;; Add more LSP servers as needed
  (add-to-list 'eglot-server-programs
               '(python-mode . ("pylsp")))
  (add-to-list 'eglot-server-programs
               '(js-mode js2-mode . ("typescript-language-server" "--stdio")))
  (add-to-list 'eglot-server-programs
               '(latex-mode . ("texlab")))
  (add-to-list 'eglot-server-programs
               '(haskell-mode . ("haskell-language-server-wrapper" "--lsp"))))

;; ============================================================================
;; Programming Language Support
;; ============================================================================

;; Python with modern setup
(use-package python-mode
  :mode ("\\.py\\'" . python-mode)
  :hook (python-mode . (lambda ()
                         (setq indent-tabs-mode nil
                               python-indent-offset 4
                               tab-width 4)))
  :config
  ;; Use system Python by default
  (when (executable-find "python3")
    (setq python-shell-interpreter "python3")))

(use-package python-black
  :if (executable-find "black")
  :hook (python-mode . python-black-on-save-mode)
  :bind (:map python-mode-map
              ("M-RET f c" . python-black-buffer)
              ("C-c C-d" . eglot-help-at-point)
              ("C-c C-z" . python-shell-switch-to-shell))
  :config
  (setq python-black-extra-args '("--line-length=88")))

;; JavaScript/TypeScript
(use-package js2-mode
  :mode (("\\.js\\'" . js2-mode)
         ("\\.jsx\\'" . js2-mode))
  :hook (js2-mode . (lambda ()
                      (setq js2-basic-offset 4
                            js-indent-level 4
                            indent-tabs-mode nil)))
  :config
  (setq js2-mode-show-strict-warnings nil))

(use-package typescript-mode
  :mode (("\\.ts\\'" . typescript-mode)
         ("\\.tsx\\'" . typescript-mode))
  :hook (typescript-mode . (lambda ()
                             (setq typescript-indent-level 4
                                   indent-tabs-mode nil))))

;; Web development
(use-package web-mode
  :mode (("\\.html\\'" . web-mode)
         ("\\.htm\\'" . web-mode)
         ("\\.eex\\'" . web-mode)
         ("\\.erb\\'" . web-mode)
         ("\\.hbs\\'" . web-mode))
  :config
  (setq web-mode-markup-indent-offset 2
        web-mode-css-indent-offset 2
        web-mode-code-indent-offset 2))

;; Haskell
(use-package haskell-mode
  :mode ("\\.hs\\'" . haskell-mode)
  :hook (haskell-mode . (lambda ()
                          (setq indent-tabs-mode nil))))

;; Markdown
(use-package markdown-mode
  :mode ("\\.md\\'" . markdown-mode)
  :commands (markdown-mode gfm-mode)
  :bind
  (:map markdown-mode-map
        ("M-RET" . nil)
        ("M-n" . nil)
        ("M-p" . nil))
  :config
  (setq markdown-command "pandoc"))

;; YAML
(use-package yaml-mode
  :mode ("\\.yml\\'" . yaml-mode)
  :hook (yaml-mode . (lambda ()
                       (setq indent-tabs-mode nil))))

;; ============================================================================
;; Modern LaTeX/LuaLaTeX Setup
;; ============================================================================

(use-package tex
  :ensure auctex
  :mode ("\\.tex\\'" . latex-mode)
  :config
  (setq TeX-engine 'luatex
        TeX-PDF-mode t
        TeX-source-correlate-mode t
        TeX-view-program-selection '((output-pdf "PDF Tools"))
        TeX-save-query nil)

  (add-hook 'LaTeX-mode-hook
            (lambda ()
              (yas-minor-mode)
              (eglot-ensure)
              (setq TeX-command-default "LuaLaTeX"))))

(use-package pdf-tools :ensure t)

;; ============================================================================
;; Version Control
;; ============================================================================

(use-package magit
  :if (executable-find "git")
  :bind (("C-x g" . magit-status)
         ("M-RET m s" . magit-status))
  :config
  (setq magit-auto-revert-mode nil
        magit-diff-refine-hunk 'all
        magit-save-repository-buffers 'dontask))

;; ============================================================================
;; Quality of Life Improvements
;; ============================================================================

;; Which-key - show available keybindings
(use-package which-key
  :init
  (which-key-mode)
  :config
  (setq which-key-idle-delay 0.3
        which-key-popup-type 'side-window))

;; Company - code completion
(use-package company
  :hook (after-init . global-company-mode)
  :config
  (setq company-idle-delay 0.2
        company-minimum-prefix-length 2
        company-tooltip-limit 20
        company-selection-wrap-around t
        company-show-numbers t
        company-tooltip-align-annotations t)
  :diminish company-mode)

;; Flycheck - syntax checking
(use-package flycheck
  :hook (after-init . global-flycheck-mode)
  :config
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  :diminish flycheck-mode)

;; Yasnippet - template system
(use-package yasnippet
  :hook (after-init . yas-global-mode)
  :config
  (setq yas-snippet-dirs (append yas-snippet-dirs
                                 '("~/.emacs.d/private/snippets")))
  (yas-reload-all)
  :bind
  ("C-<return>" . yas-expand-from-trigger-key)
  ("C-M-<return>" . yas-expand-from-trigger-key)
  ("M-RET i s" . yas-insert-snippet))

(use-package yasnippet-snippets)

;; Projectile - project management
(use-package projectile
  :init
  (projectile-mode)
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :config
  (setq projectile-switch-project-action #'projectile-dired)
  :diminish projectile-mode)

;; Expand region
(use-package expand-region
  :bind ("M-p" . er/expand-region))

;; Multiple cursors
(use-package multiple-cursors
  :bind (("C->" . mc/mark-next-like-this)
         ("C-<" . mc/mark-previous-like-this)
         ("C-c C-<" . mc/mark-all-like-this)))

;; ============================================================================
;; Visual Enhancements
;; ============================================================================

;; Theme - using your existing theme
(load-theme 'eugeneai-theme t)

;; Modeline
(use-package doom-modeline
  :ensure t
  :init
  (doom-modeline-mode 1)
  :config
  ;; Индикаторы изменений
  (setq doom-modeline-buffer-modification-icon t
        doom-modeline-buffer-state-icon t
        doom-modeline-unicode-fallback t
        doom-modeline-buffer-modification-icon " ◼ "  ; Большой квадрат
        doom-modeline-buffer-state-icon " ◼ "
        doom-modeline-lsp t
        doom-modeline-github t
        doom-modeline-mu4e t
        doom-modeline-persp-name t
        doom-modeline-minor-modes t
        doom-modeline-buffer-file-name-style 'relative-from-project)

  ;; Кастомные лица для заметности
  (custom-set-faces
   '(doom-modeline-buffer-modified ((t (:foreground "red" :weight ultra-bold))))))

;; Highlight current line
(global-hl-line-mode 1)

;; Rainbow delimiters
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; ============================================================================
;; Custom File and Local Configuration
;; ============================================================================

;; Custom file
(setq custom-file "~/.emacs.d/custom.el")
(when (file-exists-p custom-file)
  (load custom-file))

;; Load private configuration if it exists
(when (file-exists-p "~/.emacs.d/private/init.el")
  (load "~/.emacs.d/private/init.el"))

;; ============================================================================
;; Modern Bookmarks Setup
;; ============================================================================

(use-package bookmark
  :ensure nil
  :config
  (setq bookmark-default-file "~/.emacs.d/private/bookmarks.txt"
        bookmark-save-flag 1
        bookmark-version-control t
        bookmark-sort-flag t
        bookmark-use-annotations t)

  ;; Auto-save functionality
  (add-hook 'kill-emacs-hook 'bookmark-save)

  ;; Smart bookmark naming
  (defun my/smart-bookmark-set ()
    "Set bookmark with intelligent default name."
    (interactive)
    (let ((name (if (buffer-file-name)
                    (file-name-sans-extension
                     (file-name-nondirectory (buffer-file-name)))
                  (buffer-name))))
      (bookmark-set (read-string "Bookmark name: " name))))

  ;; Quick jump with completion
  (defun my/quick-bookmark-jump ()
    "Quick jump to bookmark with completion."
    (interactive)
    (bookmark-jump (completing-read "Jump to bookmark: " bookmark-alist)))

  :bind
  ("<f1>" . my/smart-bookmark-set)           ; Smart set
  ("C-<f1>" . my/quick-bookmark-jump)        ; Quick jump with completion
  ("M-<f1>" . bookmark-bmenu-list)           ; List all bookmarks
  ("C-x r l" . bookmark-bmenu-list))         ; Standard Emacs binding

;; Optional: Consult integration for even better UX
(with-eval-after-load 'consult
  (global-set-key (kbd "C-<f1>") 'consult-bookmark))

;; ============================================================================
;; Environment Setup
;; ============================================================================

;; PATH configuration
(setenv "PATH"
        (concat
         "/home/eugeneai/.local/bin" path-separator
         "/home/eugeneai/.cabal/bin" path-separator
         "/home/eugeneai/.ghcup/bin" path-separator
         "/home/eugeneai/.nix-profile/bin" path-separator
         "/nix/var/nix/profiles/default/bin" path-separator
         (getenv "PATH")))

;; Backup configuration
(defvar --backup-directory (concat user-emacs-directory "backups"))
(unless (file-exists-p --backup-directory)
  (make-directory --backup-directory t))
(setq backup-directory-alist `(("." . ,--backup-directory)))
(setq make-backup-files t
      backup-by-copying t
      version-control t
      delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      delete-by-moving-to-trash t)

;; Save history
(use-package savehist
  :init
  (savehist-mode)
  :config
  (setq savehist-additional-variables
        '(search-ring regexp-search-ring)
        savehist-autosave-interval 60
        savehist-file "~/.emacs.d/private/savehist.txt"))

;; Recent files
(use-package recentf
  :init
  (recentf-mode)
  :config
  (setq recentf-max-saved-items 200
        recentf-max-menu-items 15)
  :bind ("C-x M-r" . recentf-open-files))


;; ============================================================================
;; Custom Packages
;; ============================================================================

(use-package whole-line-or-region
  :config (whole-line-or-region-global-mode t)
  :diminish whole-line-or-region-mode)

;; Display lines for ^L characters.
(use-package page-break-lines
  :config (global-page-break-lines-mode t)
  :diminish page-break-lines-mode)

(use-package ttl-mode
  :config
  (add-hook 'ttl-mode-hook    ; Turn on font lock when in ttl mode
            'turn-on-font-lock)
  :defer t
  :mode
  (("\\.ttl\\'"      . ttl-mode)
   ("\\.n3\\'"       . ttl-mode)
   )
  )

(use-package switch-window
  :config
  (setq switch-window-threshold 2)
  :bind
  ("s-z" . switch-window)
  ("C-x o" . switch-window)
  )

(autoload 'run-prolog "prolog" "Start a Prolog sub-process." t)
(autoload 'prolog-mode "prolog" "Major mode for editing Prolog programs." t)
(autoload 'mercury-mode "prolog" "Major mode for editing Mercury programs." t)
(setq prolog-system 'swi) ;; swi
(setq auto-mode-alist
      (append '(("\\.pl$" . prolog-mode)
                ("\\.pro$" . prolog-mode)
                ("\\.m$" . mercury-mode)
                ("\\.P$" . prolog-mode)
                )
              auto-mode-alist)
      )

(autoload 'logtalk-mode "logtalk" "Major mode for editing Logtalk programs." t)
(add-to-list 'auto-mode-alist '("\\.lgt\\'" . logtalk-mode))
(add-to-list 'auto-mode-alist '("\\.logtalk\\'" . logtalk-mode))
(add-hook 'logtalk-mode-hook (lambda ()
                               (yas-minor-mode-on)
                               (setq tab-width 3)
                               (setq-default indent-tabs-mode nil)
                               ))

;; ============================================================================
;; Custom Functions
;; ============================================================================

(defun kill-current-buffer ()
  "Kill the current buffer."
  (interactive)
  (kill-buffer (current-buffer)))

(defun beginning-of-line-or-indentation ()
  "Move to beginning of line, or indentation."
  (interactive)
  (if (bolp)
      (back-to-indentation)
    (beginning-of-line)))

(defun unfill-paragraph ()
  "Take a multi-line paragraph and make it into a single line of text."
  (interactive)
  (let ((fill-column (point-max)))
    (fill-paragraph nil)))

(defun rg ()
  "Запуск rg вместе с helm."
  (interactive)
  (consult-ripgrep))

(defun ag ()
  "Запуск rg вместе с helm."
  (interactive)
  (rg))

(defun my/cleanup-before-save ()
  "Очистить файл перед сохранением с настройками."
  (interactive)
  (when (and buffer-file-name
             (file-writable-p buffer-file-name)
             (not (derived-mode-p 'makefile-mode))) ; исключения
    (let ((inhibit-message t)) ; отключить сообщения
      ;; Удалить пробелы в конце строк
      (delete-trailing-whitespace (point-min) (point-max))

      ;; Добавить новую строку в конец если нужно
      (unless (and (= (point-min) (point-max)) ; пустой файл
                   (not (eq major-mode 'fundamental-mode)))
        (save-excursion
          (goto-char (point-max))
          (unless (or (bolp)
                      (eq (char-before) ?\n))
            (insert "\n")))))))

;; Включить для всех буферов
(add-hook 'before-save-hook 'my/cleanup-before-save)


(defalias 'qrr 'query-replace-regexp)

(defun external-difftool-current-file ()
  "Open current file in external diff tool against last commit."
  (interactive)
  (if (and (buffer-file-name)
           (locate-dominating-file (buffer-file-name) ".git"))
      (let ((default-directory (locate-dominating-file (buffer-file-name) ".git")))
        (shell-command
         (format "git difftool --no-prompt HEAD -- %s &"
                 (file-relative-name (buffer-file-name) default-directory)))
        (message "📊 Opening difftool for current file..."))
    (message "❌ Not in a git repository")))

(global-set-key (kbd "M-RET g d") 'external-difftool-current-file)

;; ;; Явно загрузить makefile-mode
;; (require 'makefile-mode)

;; ;; Добавить ассоциацию файлов
;; (add-to-list 'auto-mode-alist '("[Mm]akefile\\'" . makefile-mode))
;; (add-to-list 'auto-mode-alist '("\\.mk\\'" . makefile-mode))
;; (add-to-list 'auto-mode-alist '("\\.[Mm]akefile\\." . makefile-mode))

;; (use-package makefile-mode
;;   :ensure nil
;;   :hook
;;   (makefile-mode . (lambda ()
;;                      ;; Enable completion
;;                      (setq-local company-backends
;;                                  '(company-makefile company-dabbrev-code))

;;                      ;; Enable other useful features
;;                      (abbrev-mode 1)
;;                      (electric-indent-local-mode -1)

;;                      ;; Custom keybindings
;;                      (local-set-key (kbd "C-c C-c") 'compile)))

;;   :config
;;   ;; Company backend for Makefile
;;   (defun company-makefile (command &optional arg &rest ignored)
;;     "Company backend for Makefile mode."
;;     (interactive (list 'interactive))
;;     (cl-case command
;;       (interactive (company-begin-backend 'company-makefile))
;;       (prefix (and (derived-mode-p 'makefile-mode)
;;                    (company-grab-symbol)))
;;       (candidates
;;        (cl-remove-duplicates
;;         (append (makefile-targets) (makefile-variables))
;;         :test 'string=))
;;       (meta (format "Value: %s" arg))
;;       (annotation (makefile-annotation arg))))

;;   (defun makefile-targets ()
;;     "Get all targets from current Makefile."
;;     (save-excursion
;;       (goto-char (point-min))
;;       (let (targets)
;;         (while (re-search-forward "^\\([a-zA-Z0-9][a-zA-Z0-9._-]*\\)\\(?:\\s-*:\\)" nil t)
;;           (push (match-string 1) targets))
;;         (reverse targets))))

;;   (defun makefile-variables ()
;;     "Get all variables from current Makefile."
;;     (save-excursion
;;       (goto-char (point-min))
;;       (let (vars)
;;         (while (re-search-forward "^\\([A-Za-z0-9_][A-Za-z0-9_-]*\\)\\s-*[?+]?=" nil t)
;;           (push (match-string 1) vars))
;;         (reverse vars))))

;;   (defun makefile-annotation (candidate)
;;     "Return annotation for CANDIDATE."
;;     (cond
;;      ((member candidate (makefile-targets)) " [target]")
;;      ((member candidate (makefile-variables)) " [var]")
;;      (t ""))))

;; (defun consult-makefile-target ()
;;   "Select Makefile target with consult."
;;   (interactive)
;;   (when (derived-mode-p 'makefile-mode)
;;     (let ((target (completing-read "Make target: " (makefile-targets))))
;;       (compile (format "make %s" target)))))

;; (add-hook 'makefile-mode-hook
;;           (lambda ()
;;             (local-set-key (kbd "C-c m") 'consult-makefile-target)))

;; ============================================================================
;; Custom Newline Bindings
;; ============================================================================

;; C-o behaves like C-j (newline with indent)
(global-set-key (kbd "C-o") 'newline-and-indent)

;; M-o inserts newline above current line
(defun open-line-above ()
  "Insert a new line above the current line and indent it."
  (interactive)
  (unless (bolp)
    (beginning-of-line))
  (newline)
  (forward-line -1)
  (indent-according-to-mode))

(global-set-key (kbd "M-o") 'open-line-above)

;; Optional: Also bind to standard Emacs keys for consistency
(global-set-key (kbd "C-j") 'newline-and-indent)  ; Ensure C-j does the same

;; ============================================================================
;; Russian Layout Fix
;; ============================================================================

(use-package reverse-im
  :ensure t
  :demand t
  :config
  (reverse-im-mode t)
  (reverse-im-activate "russian-computer")

  ;; Настройки для лучшей работы
  (setq reverse-im-char-fold t
        reverse-im-read-char-advice-function #'reverse-im-read-char-include
        reverse-im-input-methods '("russian-computer"))

  ;; Активировать для русской раскладки
  (reverse-im-activate "russian-computer")

  ;; Дополнительные настройки
  (setq reverse-im-translate-keys '((?ф . ?а)   ; f -> a
                                    (?ы . ?ы)   ; s -> s
                                    (?в . ?д)   ; v -> d
                                    (?а . ?ф)   ; a -> f
                                    (?п . ?з)   ; p -> z
                                    (?р . ?к)   ; r -> k
                                    (?о . ?л)   ; o -> l
                                    (?л . ?д)   ; l -> d
                                    (?д . ?у)   ; d -> u
                                    (?ж . ?э)   ; ; -> '
                                    (?э . ?ж)   ; ' -> ;
                                    (?я . ?z)   ; z -> z
                                    (?ч . ?x)   ; x -> x
                                    (?с . ?c)   ; c -> c
                                    (?м . ?v)   ; m -> v
                                    (?и ??)     ; b -> b
                                    (?т ??)     ; n -> n
                                    (?ь ??)     ; m -> m
                                    )))

;; Функция для получения системной раскладки
(defun get-system-layout ()
  "Get current system keyboard layout using setxkbmap."
  (string-trim
   (shell-command-to-string
    "setxkbmap -query | grep layout | awk '{print $2}'")))

;; Синхронизация раскладки
(defun sync-with-system-layout ()
  "Sync Emacs input method with system keyboard layout."
  (interactive)
  (let ((layout (get-system-layout)))
    (cond
     ((string= layout "ru")
      (set-input-method "russian-computer")
      (message "🇷🇺 Русская раскладка (синхронизировано)"))
     ((string= layout "us")
      (deactivate-input-method)
      (message "🇺🇸 Английская раскладка (синхронизировано)"))
     (t
      (toggle-input-method)
      (message "Переключена раскладка Emacs")))))

(global-set-key (kbd "C-\\") 'sync-with-system-layout)


;; ============================================================================
;; Move Lines with M-arrows
;; ============================================================================

(use-package drag-stuff
  :ensure t
  :config
  (drag-stuff-global-mode 1)
  (drag-stuff-define-keys)

  ;; Дополнительные настройки
  (setq drag-stuff-mode t)

  ;; Биндинги M-стрелок
  :bind
  ("M-<up>" . drag-stuff-up)
  ("M-<down>" . drag-stuff-down)
  ("M-<left>" . drag-stuff-left)
  ("M-<right>" . drag-stuff-right))

;; ============================================================================
;; Key Bindings
;; ============================================================================

;; Navigation
(global-set-key (kbd "C-a") 'beginning-of-line-or-indentation)
(global-set-key (kbd "C-|") 'beginning-of-buffer)
(global-set-key (kbd "C-}") 'end-of-buffer)

;; Compilation
(global-set-key (kbd "C-x c") 'compile)
(global-set-key (kbd "C-x !") 'shell)

;; Utility
(global-set-key (kbd "C-x e") 'erase-buffer)
(global-set-key (kbd "C-z") 'undo)

(global-set-key (kbd "C-x C-\\") 'consult-mark)

;; Быстрое увеличение/уменьшение шрифта
(global-set-key (kbd "C-c +") 'text-scale-increase)
(global-set-key (kbd "C-c -") 'text-scale-decrease)
(global-set-key (kbd "C-c 0") 'text-scale-adjust)
(global-set-key (kbd "M-i") 'helm-occur)

;; Предустановленные режимы
(defun big-font-mode ()
  "Большой шрифт для проектора."
  (interactive)
  (set-face-attribute 'default nil :height 160)
  (message "🔍 Большой шрифт для проектора"))

(defun normal-font-mode ()
  "Нормальный размер шрифта."
  (interactive)
  (set-face-attribute 'default nil :height 120)
  (message "📝 Нормальный размер шрифта"))

(global-set-key (kbd "C-c b") 'big-font-mode)
(global-set-key (kbd "C-c m") 'normal-font-mode)

;; ============================================================================
;; Final Initialization
;; ============================================================================

;;; DeepSeek API Key Configuration

(defun load-deepseek-api-key ()
  "Load DEEPSEEK_API_KEY from various sources with proper newline handling."
  (let ((api-key nil))
    ;; 1. Check environment variable first
    (setq api-key (getenv "DEEPSEEK_API_KEY"))

    ;; 2. If not in environment, check ~/.deepseek_api_key file
    (when (and (not api-key) (file-exists-p "~/.deepseek_api_key"))
      (with-temp-buffer
        (insert-file-contents "~/.deepseek_api_key")
        (setq api-key (string-trim (buffer-string))) ; Remove newlines and whitespace
        (message "Loaded DeepSeek API key from ~/.deepseek_api_key")))

    ;; 3. If still not found, check shell config files
    (when (not api-key)
      (let ((shell-files '("~/.bashrc" "~/.bash_profile" "~/.zshrc" "~/.profile")))
        (catch 'found
          (dolist (file shell-files)
            (when (file-exists-p file)
              (with-temp-buffer
                (insert-file-contents file)
                (goto-char (point-min))
                (when (re-search-forward "export DEEPSEEK_API_KEY=[\"']?\\([^\"'\n]+\\)[\"']?" nil t)
                  (setq api-key (match-string 1))
                  (message "Loaded DeepSeek API key from %s" file)
                  (throw 'found t))))))))

    ;; Return the key (or nil if not found)
    api-key))

(defun setup-deepseek-api-key ()
  "Setup DeepSeek API key with proper error handling."
  (let ((api-key (load-deepseek-api-key)))

    (cond
     ((not api-key)
      (message "❌ DeepSeek API key not found in any source")
      nil)

     ((string-empty-p api-key)
      (message "❌ DeepSeek API key is empty")
      nil)

     (t
      ;; Set both environment variable and gptel-api-key
      (setenv "DEEPSEEK_API_KEY" api-key)
      (setq gptel-api-key api-key)
      (message "✅ DeepSeek API key configured successfully: %s..."
               (substring api-key 0 (min 8 (length api-key))))
      api-key))))

;; Initialize DeepSeek API key on startup
(when (and (featurep 'gptel)
           (not (getenv "DEEPSEEK_API_KEY")))
  (setup-deepseek-api-key))

(use-package gptel
  :defer 1
  :config
  ;; Ensure API key is loaded before setting up gptel
  (unless (getenv "DEEPSEEK_API_KEY")
    (setup-deepseek-api-key))

  ;; Increase context size for longer sessions
  (setq gptel-max-tokens 8192)  ; Double the default context size
  (setq gptel-track-context t)  ; Track conversation context

  (let ((api-key (getenv "DEEPSEEK_API_KEY")))
    (when api-key
      (gptel-make-deepseek "DeepSeek"
        :stream t
        :key api-key)

      (setq gptel-model 'deepseek-chat
            gptel-backend (gptel-make-deepseek "DeepSeek"
                            :stream t
                            :key api-key))
      (message "GPTel DeepSeek backend configured with API key")))

  :bind
  ("M-RET g s" . gptel-send)
  ("M-RET g u s" . gptel-send))

(use-package gptel-aibo
  :ensure t
  :bind
  ("M-RET M-RET" . gptel-aibo-send)
  ("M-RET a a" . gptel-aibo-send)
  ("M-RET a s" . gptel-aibo-apply-last-suggestions) ;; TODO настроить на работу C-u, M-X
  :config
  ;; Inherit context settings from gptel
  (defalias 'aibo 'gptel-aibo)
  (defalias 'aibo-send 'gptel-aibo-send)
  (defalias 'aibo-apply-last-suggestions 'gptel-aibo-apply-last-suggestions)

  ;; Additional aibo-specific context settings
  (setq gptel-aibo-max-context-lines 50)  ; Keep more context lines
  )


;; ============================================================================
;; Final Initialization
;; ============================================================================

;; Enable global auto-revert mode
(global-auto-revert-mode t)

;; Set final garbage collection threshold
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 20 1024 1024)))) ; 20MB

(disable-proxy-after-packages)

;; ThisIsFourWords
(global-subword-mode t) ;; CamelCaseSubword

;; Be aware of whitespace.
(setq whitespace-style '(face trailing tabs tab-mark))
(global-whitespace-mode)
(diminish 'global-whitespace-mode)

;; Don't insert tabs.
(setq-default indent-tabs-mode nil)

;; Use just 'y' or 'n', not 'yes' or 'no'.
(defalias 'yes-or-no-p 'y-or-n-p)
;; Do the same for running elisp in org-mode.
(setq org-confirm-elisp-link-function 'y-or-n-p)

;; Easily memorable whole-buffer selection.
(global-set-key (kbd "M-A") 'mark-whole-buffer)

(provide 'init)
;;; init.el ends here
