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
  "Временно включить proxy для установки пакетов"
  (interactive)
(setq url-proxy-services '(("no_proxy" . "127\\.0\\.0\\.1")
                           ("http" . "192.168.191.201:3128")
                           ("https" . "192.168.191.201:3128")
                           ("ftp" . "192.168.191.201:3128")))
  (message "Proxy включен для установки пакетов"))

(defun disable-proxy-after-packages ()
  "Отключить proxy после установки пакетов"
  (interactive)
  (setq url-proxy-services nil)
  (message "Proxy отключен"))

(enable-proxy-for-packages)

;; Initialize package system
(require 'package)

;; Configure package archives with SSL support
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")) t)
  (add-to-list 'package-archives (cons "elpy" (concat proto "://jorgenschaefer.github.io/packages/")) t))

(package-initialize)

;; Refresh package contents if needed
(unless (file-exists-p "~/.emacs.d/elpa/archives/melpa")
  (package-refresh-contents))

;; Bootstrap use-package
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

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
  :bind (("C-s" . consult-line)
         ("C-M-l" . consult-buffer)
         ("M-y" . consult-yank-pop)
         ("M-g g" . consult-goto-line)
         ("M-g M-g" . consult-goto-line)
         :map minibuffer-local-map
         ("C-r" . consult-history)))

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
  :hook ((python-mode js-mode js2-mode typescript-mode haskell-mode) . eglot-ensure)
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
  :config
  (setq python-black-extra-args '("--line-length=88")))

;; JavaScript/TypeScript
(use-package js2-mode
  :mode (("\\.js\\'" . js2-mode)
         ("\\.jsx\\'" . js2-mode))
  :hook (js2-mode . (lambda ()
                      (setq js2-basic-offset 2
                            indent-tabs-mode nil)))
  :config
  (setq js2-mode-show-strict-warnings nil))

(use-package typescript-mode
  :mode (("\\.ts\\'" . typescript-mode)
         ("\\.tsx\\'" . typescript-mode))
  :hook (typescript-mode . (lambda ()
                             (setq typescript-indent-level 2
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
  :config
  (setq markdown-command "pandoc"))

;; YAML
(use-package yaml-mode
  :mode ("\\.yml\\'" . yaml-mode)
  :hook (yaml-mode . (lambda ()
                       (setq indent-tabs-mode nil))))

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
  (yas-reload-all))

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
  :init (doom-modeline-mode)
  :config
  (setq doom-modeline-height 25
        doom-modeline-bar-width 3
        doom-modeline-minor-modes t))

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
  "Takes a multi-line paragraph and makes it into a single line of text."
  (interactive)
  (let ((fill-column (point-max)))
    (fill-paragraph nil)))

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

(provide 'init)
;;; init.el ends here
