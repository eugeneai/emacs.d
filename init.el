;;; Configuration --- Summary
;;; Commentary:
;; This is configuration for Emacs.
;;; Code:
;; init.el --- Emacs configuration

(setq debug-on-error t)

;; Just a sec - have to clean things up a little!
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(setq inhibit-startup-screen t)
(setq custom-file "~/.emacs.d/private/custom.el")
(load-file custom-file)

;; Welcome!
(setq user-full-name "Evgeny Cherkashin"
      user-mail-address "eugeneai@irnok.net")

;; BASIC CUSTOMIZATION
;; --------------------------------------

;(global-linum-mode t) ;; enable line numbers globally

;; If async is installed
(add-to-list 'load-path "~/.emacs.d/site-lisp")
(add-to-list 'load-path "~/.emacs.d/private")
(add-to-list 'load-path "~/.emacs.d/site-lisp/helm")
(add-to-list 'load-path "~/.emacs.d/site-lisp/async")

;(setq dotfiles-dir (expand-file-name "~/.emacs.d/"))
;(setq site-lisp-dir (expand-file-name "site-lisp" dotfiles-dir))
;(add-to-list 'load-path site-lisp-dir)


(load-theme 'eugeneai-theme t)


;; Proxy Settings

(setq windowed-system (or (eq window-system 'x) (eq window-system 'w32)))
(setq win32-system (eq window-system 'w32))

(if (eq window-system 'w32)
    (progn
      (if (file-directory-p "c:/GNU/bin")
          (progn
            (add-to-list 'exec-path "c:/GNU/bin")
            )
        )
      (setq url-proxy-services '(("no_proxy" . "172.27.24.")
                                 ("http" . "titan.cyber:ghbdtnbr@172.27.100.5:4444")))

      )
  )



;; This package called package comes with Emacs.
(require 'package)
;; Turn on packaging.
(package-initialize)

(setq package-archives '(
                         ("melpa" . "http://melpa.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("elpa" . "http://elpa.gnu.org/packages/")
                         ("elpy" . "http://jorgenschaefer.github.io/packages/")
                         ("org" . "http://orgmode.org/elpa/")
                         ))

(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))


;; From github.com/magnars/.emacs.d:
;; Ensure we have MELPA package awareness.
(unless (file-exists-p "~/.emacs.d/elpa/archives/melpa")
  (package-refresh-contents))

;; From github.com/sachac/.emacs.d:
;; Bootstrap install of use-package,
;; which also installs diminish.
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(setq use-package-verbose t)
(require 'use-package)
(setq use-package-always-ensure t)
;; After this, use-package will install things as needed.


;; ThisIsFourWords
(global-subword-mode t) ;; CamelCaseSubword

;; Consider using abbreviations.
(add-hook 'text-mode-hook (lambda () (abbrev-mode 1)))
(setq abbrev-file-name             ;; tell emacs where to read abbrev
      "~/.emacs.d/private/abbrev_defs")    ;; definitions from...
(setq save-abbrevs t)              ;; save abbrevs when files are saved
;; you will be asked before the abbreviations are saved

;; TODO: Study abbrev mode

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


;; Don't show so many stars in org-mode.
;(setq org-hide-leading-stars t)


;; Improve mode-line:
;; Show system time.
(display-time-mode t)
;; Show column number.
(setq column-number-mode t)
;; Don't show trailing dashes.
(setq mode-line-end-spaces "")


;; Blink, don't beep.
(setq visible-bell t)
;; A good setting, but resulting in visual artifacts.

;; One space after sentences. Two.
(setq sentence-end-double-space t)


;; Update the screen by one line, not one page.
(setq scroll-step 1)

;; Allow region downcase w/ C-x C-l, upcase w/ C-x C-u.
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'narrow-to-region 'disabled nil)

;; Make nice buffer names when multiple files have the same name.
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

(defvar --backup-directory (concat user-emacs-directory "backups"))
(if (not (file-exists-p --backup-directory))
            (make-directory --backup-directory t))
(setq backup-directory-alist `(("." . ,--backup-directory)))
(setq make-backup-files t          ; backup file the first time it is saved
      backup-by-copying t          ; don't clobber symlinks
      version-control t            ; version numbers for backup files
      delete-old-versions t        ; delete excess backup files silently
      delete-by-moving-to-trash t  ; system recycle bin or whatever
      auto-save-default t          ; auto-save every buffer that visits file
      vc-make-backup-files t       ; backup version-controlled files too
      )


;;; Set some keybindings.

;; Use shift-arrows for changing windows.
(windmove-default-keybindings)

;; Use Mac keys:
(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'super)
(setq ns-function-modifier 'hyper)


;; Jump easily to beginning and end.
(global-set-key (kbd "C-|") 'beginning-of-buffer)
(global-set-key (kbd "C-}") 'end-of-buffer)

;; Easily memorable whole-buffer selection.
(global-set-key (kbd "M-A") 'mark-whole-buffer)

;; Easily turn line numbers on and off.
(global-set-key (kbd "C-`") 'linum-mode)

;; switch point into buffer list
(global-set-key (kbd "C-x C-b") 'buffer-menu)

;; dired at point is nice
(global-set-key (kbd "C-x C-j") 'dired-at-point)



;; Make C-h and M-h backspace; move help to C-x h.
;; (On some systems, C-h already sends DEL.)
;(global-set-key (kbd "C-x h") 'help-command)


;; Highlight where matching parens are.
(show-paren-mode t)

;; INSTALL PACKAGES
;; --------------------------------------

(use-package better-defaults)
(use-package ag)

;; `smartparens` manages parens well.
(use-package smartparens
  :config
  (require 'smartparens-config)
  (smartparens-global-mode t)
  (define-key smartparens-mode-map (kbd "C-M-f") 'sp-forward-sexp)
  (define-key smartparens-mode-map (kbd "C-M-b") 'sp-backward-sexp)
  ;; C-M-j isn't standard, but C-M-d doesn't work for me.
  (define-key smartparens-mode-map (kbd "C-M-j") 'sp-down-sexp)
  (define-key smartparens-mode-map (kbd "C-M-k") 'sp-kill-sexp)
  (define-key smartparens-mode-map (kbd "C-M-w") 'sp-copy-sexp)
  (define-key smartparens-mode-map (kbd "C-M-[") 'sp-rewrap-sexp)
  (define-key smartparens-mode-map (kbd "C-M-]") 'sp-backward-unwrap-sexp)
  ;; markdown-mode
  (sp-with-modes '(markdown-mode gfm-mode rst-mode)
    (sp-local-pair "*" "*"
                   :wrap "C-*"
                   :unless '(sp-point-after-word-p sp-point-at-bol-p)
                   :post-handlers '(("[d1]" "SPC"))
                   :skip-match 'sp--gfm-skip-asterisk)
    (sp-local-pair "**" "**")
    (sp-local-pair "_" "_" :wrap "C-_" :unless '(sp-point-after-word-p)))
  (defun sp--gfm-skip-asterisk (ms mb me)
    (save-excursion
      (goto-char mb)
      (save-match-data (or (looking-at "^\\* ")
                           (looking-at "^ \\* ")))))
  ;; Don't highlight when wrapping.
  (setq sp-highlight-pair-overlay nil)
  (setq sp-highlight-wrap-overlay nil)
  (setq sp-highlight-wrap-tag-overlay nil)
  :diminish smartparens-mode)


;; Move things around intuitively.
(use-package drag-stuff
  :config
  (drag-stuff-global-mode)
  (drag-stuff-define-keys)
  :diminish drag-stuff-mode)


;; expand-region is that new hotness.
(use-package expand-region
  :bind ("M-p" . er/expand-region))


;;Use nice colors.
(use-package zenburn-theme
  :disabled t
  :config
  (load-theme 'zenburn t)
  )

(use-package material-theme
  :disabled t
  :config
  (load-theme 'material t)
  )

;; FIXME: Cannot load it
(use-package spacemacs-theme
  :disabled t
  :config
  (load-theme 'spacemacs-dark t)
  )

;; Themes can be disabled with disable-theme.


;; Get useful line behaviors when region is not active.
(use-package whole-line-or-region
  :config (whole-line-or-region-mode t)
  :diminish whole-line-or-region-mode)


;; Work with git with magic ease.
(use-package magit
  :bind
  ("C-x g" . magit-status)
  :config
  (setq magit-push-always-verify nil)
  (set-default 'magit-unstage-all-confirm t)
  (set-default 'magit-stage-all-confirm t)
  (set-default 'magit-revert-buffers 'silent)
  (global-set-key "\C-x\ \C-m" 'magit-status)
;; Don't use tabs, magit!
  (add-hook 'git-commit-mode-hook
            '(lambda () (untabify (point-min) (point-max))) t))

(use-package magit-filenotify
  :config
  (add-hook 'after-save-hook 'magit-after-save-refresh-status)
  (add-hook 'magit-status-mode-hook 'magit-filenotify-mode)
  )

(use-package magithub
  :disabled 1
  :after magit)

;; Fix to git-gutter+
;; See https://github.com/nonsequitur/git-gutter-plus/pull/27
;; Use the fringe if in graphical mode (not terminal).
(if (or (display-graphic-p) (daemonp))
    (require 'git-gutter-fringe+)
  (require 'git-gutter+))
(global-git-gutter+-mode)
(diminish 'git-gutter+-mode)
;; ;; Eventually may be able to return to something like this:
;; (use-package git-gutter-fringe+
;;   :init (global-git-gutter+-mode)
;;   :diminish git-gutter+-mode)

;; Interactive selection of things.
;; TODO: consider helm instead (see Sacha's config)
;; NOTE: "C-j: Use the current input string verbatim."
(ido-mode t)
(ido-everywhere t)
;; disable ido faces to see flx highlights.
(setq ido-enable-flex-matching t)
(setq ido-use-faces nil)
;(global-set-key (kbd "M-l") 'other-window)
;(global-set-key (kbd "C-M-l") 'ido-switch-buffer)

;; list vertically (so much nicer!)
(use-package ido-vertical-mode
  :config
  (ido-vertical-mode t)
  (setq ido-vertical-define-keys 'C-n-C-p-up-and-down))

(use-package flx-ido
  :config (flx-ido-mode 1))

;; Smart M-x
(use-package smex
  :config
  (smex-initialize)
  (global-set-key (kbd "M-x") 'smex)
  ;; take Yegge's advice and don't require M for M-x
  ;;; (global-set-key (kbd "C-x C-m") 'smex)
  ;; This is the old M-x.
  (global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)
  (global-set-key (kbd "M-X") 'smex-major-mode-commands))


;; See the undo history and move through it.
(use-package undo-tree
  :disabled t
  :config (global-undo-tree-mode t)
  :diminish undo-tree-mode)

;; Add nice project functions for git repos.
(use-package projectile
  :config
  (projectile-global-mode)
  (global-set-key (kbd "C-<f6>") 'projectile-find-file)
  :diminish projectile-mode)
;; TODO: rojectile-helm

;; Un-namespaced Common Lisp names.
;; https://github.com/browse-kill-ring/browse-kill-ring/pull/56
(require 'cl)
(use-package browse-kill-ring
  :config
  ;; Bind M-y to visual interactive kill ring.
  (browse-kill-ring-default-keybindings))

;; Display lines for ^L characters.
(use-package page-break-lines
  :config (global-page-break-lines-mode t)
  :diminish page-break-lines-mode)

;; Edit in multiple places at the same time.
(use-package multiple-cursors
  :bind
  ("C-x r t" . mc/edit-lines)
  ("C-x C-x" . mc/mark-more-like-this-extended))


;; (Near) simultaneous keypresses create new keys.
(use-package key-chord
  :disabled t
  :config
  (key-chord-mode t)
  (key-chord-define-global "hj" 'undo))


;; Flip through buffers with ease.
(use-package buffer-stack
  :disabled 1
  :config
  (key-chord-define-global "jk" 'buffer-stack-down))



;; Conveniently zoom all of Emacs.
(use-package zoom-frm
  :bind
  ("C-=" . zoom-in/out)
  ("C-+" . zoom-in/out)
  ("C--" . zoom-in/out))


;; Check syntax, make life better.
(use-package flycheck
  :config
  (add-hook 'after-init-hook #'global-flycheck-mode)
  (define-key flycheck-mode-map
    (kbd "C-c C-n")
    'flycheck-next-error)
  (define-key flycheck-mode-map
    (kbd "C-c C-p")
    'flycheck-previous-error)
  :diminish flycheck-mode)


;; Elpy the Emacs Lisp Python Environment.
(use-package elpy
  :config
  (elpy-enable)
  ;; Use ipython if available.
  ;(when (executable-find "ipython")
  ;  (elpy-use-ipython))
  ;; Don't use flymake if flycheck is available.
  (when (require 'flycheck nil t)
    (setq elpy-modules
          (delq 'elpy-module-flymake elpy-modules))
    (add-hook 'elpy-mode-hook 'flycheck-mode))
  ;; Don't use highlight-indentation-mode.
  (delete 'elpy-module-highlight-indentation elpy-modules)
  ;; this is messed with by emacs if you let it...
  (custom-set-variables
   '(elpy-rpc-backend "jedi")
   '(help-at-pt-display-when-idle (quote (flymake-overlay)) nil (help-at-pt))
   '(help-at-pt-timer-delay 0.9)
   '(tab-width 4))
  (define-key elpy-mode-map (kbd "C-c C-n") 'next-error)
  (define-key elpy-mode-map (kbd "C-c C-p") 'previous-error)
  ;; Elpy also installs yasnippets.
  ;; Don't use tab for yasnippets, use shift-tab.
  (define-key yas-minor-mode-map (kbd "<tab>") nil)
  (define-key yas-minor-mode-map (kbd "TAB") nil)
  (define-key yas-minor-mode-map (kbd "<backtab>") 'yas-expand)
  (add-hook 'after-init-hook 'global-company-mode)
  (setq company-idle-delay 0.2)
  (setq company-minimum-prefix-length 1)
  (elpy-enable)
  :diminish elpy-mode)

(use-package py-autopep8
  :config
  (add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)
  )

;; Emacs Speaks Statistics includes support for R.
(use-package ess-site
  :ensure ess)


;; Use a nice JavaScript mode.
(use-package js2-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode)))


;; See colors specified with text.
(use-package rainbow-mode
  :config
  (defun rainbow-mode-quietly ()
    (rainbow-mode)
    (diminish 'rainbow-mode))
  (add-hook 'html-mode-hook 'rainbow-mode-quietly)
  (add-hook 'css-mode-hook 'rainbow-mode-quietly))

;; TODO: May be set some nice palette.
(use-package rainbow-delimiters
  :config
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
  )

;; Support markdown, for goodness sake.
(use-package markdown-mode
  :config
  (define-key markdown-mode-map (kbd "M-n") nil)
  (define-key markdown-mode-map (kbd "M-p") nil))

(use-package markdown-mode+)

(use-package goto-last-change
  :config
  (global-set-key (kbd "C-x C-\\") 'goto-last-change)
)

(use-package ac-ispell
  :config
  (add-hook 'text-mode-hook '(lambda ()
                               (custom-set-variables
                                '(ac-ispell-requires 3)
                                '(ac-ispell-fuzzy-limit 2))
                               ;(auto-complete-mode)
                               ;(ac-ispell-ac-setup)
                               ))
  (ac-ispell-setup)
  ; TODO Does not work now
  )

;; FIXME: Does not install
(use-package tex
  :ensure auctex
  :config
  (custom-set-variables
                                        ; '(TeX-install-font-lock 'tex-font-setup)
   '(TeX-auto-save t)
   '(TeX-parse-self t)
   '(TeX-master nil)
   '(TeX-save-query nil)
   '(TeX-source-correlate-method (quote synctex))
   '(TeX-source-correlate-mode t)
   '(TeX-source-correlate-start-server (quote ask)))
  (setq font-latex-fontify-script nil
        font-latex-fontify-sectioning 'color)
)

(use-package auctex-latexmk
  :after tex
  :config
  (auctex-latexmk-setup)
  )

(use-package color-theme)
(use-package color)
(use-package fiplr
  :config
  (setq fiplr-root-markers '(".git" ".svn"))
  (setq fiplr-ignored-globs '((directories (".git" ".svn"))
                              (files ("*.jpg" "*.png" "*.zip" "*~"))))
  (global-set-key (kbd "C-x f") 'fiplr-find-file)
  )

(use-package w3m
  :config
  ;; Multitran dictionary lookup
  (defun multitran-lookup-english (keyword)
    (interactive (list (thing-at-point 'word)))
    (switch-to-buffer-other-window
     (eww
      ;; (w3m-goto-url
      (concat "http://multitran.ru/c/m.exe?l1=1&s=" keyword "&%CF%EE%E8%F1%EA=%CF%EE%E8%F1%EA")
      )
     )
    ;;(run-at-time 4 nil 'iconify-frame)
    )
  (global-set-key (kbd "C-c m") 'multitran-lookup-english)
  )
(use-package recentf
  :config
  (setq recentf-auto-cleanup 'never) ;; disable before we start recentf!
  (recentf-mode t)
  (recentf-load-list)
  (setq
   ;;  recentf-menu-path '("File")
   ;;  recentf-menu-title "Recent"
   recentf-max-saved-items 200
   recentf-max-menu-items 10
   )
  )

(use-package yasnippet
  :config
  (setq yas-snippet-dirs (append yas-snippet-dirs
                                 '("~/.emacs.d/snippets")))
  (yas-reload-all)
  (yas-global-mode 1)
)

(use-package swiper
  :disabled t
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (global-set-key "\C-s" 'swiper)
  (global-set-key (kbd "C-c C-r") 'ivy-resume)
  (global-set-key (kbd "<f6>") 'ivy-resume)
  (global-set-key (kbd "M-x") 'counsel-M-x)
  (global-set-key (kbd "C-x C-f") 'counsel-find-file)
  (global-set-key (kbd "<f1> f") 'counsel-describe-function)
  (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
  (global-set-key (kbd "<f1> l") 'counsel-find-library)
  (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
  (global-set-key (kbd "<f2> u") 'counsel-unicode-char)
  (global-set-key (kbd "C-c g") 'counsel-git)
  (global-set-key (kbd "C-c j") 'counsel-git-grep)
  (global-set-key (kbd "C-c k") 'counsel-ag)
  (global-set-key (kbd "C-x l") 'counsel-locate)
  (global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
  (define-key read-expression-map (kbd "C-r") 'counsel-expression-history)
  )

(use-package flyspell
  :config
  (setq ispell-local-dictionary-alist
        '(("russian"
           "[АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЬЫЪЭЮЯабвгдеёжзийклмнопрстуфхцчшщьыъэюя]"
           "[^АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЬЫЪЭЮЯабвгдеёжзийклмнопрстуфхцчшщьыъэюя]"
           "[-]"  nil ("-d" "ru_RU") nil utf-8)
          ("english"
           "[A-Za-z]" "[^A-Za-z]"
           "[']"  nil ("-d" "en_US") nil iso-8859-1)))
  ;; вместо aspell использовать hunspell
  (setq ispell-really-aspell nil
        ispell-really-hunspell t
        ispell-dictionary "english")
  (setq ispell-program-name "/usr/local/bin/hunspell")
  ;; ;(require 'ispell)
  (defun fd-switch-dictionary()
    (interactive)
    (let* ((dic ispell-current-dictionary)
           (change (if (string= dic "russian") "english" "russian")))
      (ispell-change-dictionary change)
      (message "Dictionary switched from %s to %s" dic change)
      ))
  (global-set-key (kbd "<f8>")   'fd-switch-dictionary)
  (add-hook 'text-mode-hook (lambda ()
                              (flyspell-mode)
                              (diminish 'flyspell-mode)))
  (add-hook 'prog-mode-hook (lambda ()
                              (flyspell-prog-mode)
                              (diminish 'flyspell-mode)))
  ; ispell-alternate-dictionary
  )

;; TODO: My stuff

;; Some almost mystic setup
(setq echo-keystrokes 0.1
      font-lock-maximum-decoration t
      inhibit-startup-message t
      transient-mark-mode t
      color-theme-is-global t
      delete-by-moving-to-trash t
      shift-select-mode nil
      mouse-yank-at-point nil
      require-final-newline t
      truncate-partial-width-windows nil
      ;uniquify-buffer-name-style 'forward
      ;whitespace-style '(trailing lines space-before-tab
      ;                            indentation space-after-tab)
      whitespace-line-column 80
      ediff-window-setup-function 'ediff-setup-windows-plain
      xterm-mouse-mode t
      )

(defun kill-current-buffer ()
  (interactive)
  (kill-buffer (current-buffer)))

(global-set-key (kbd "C-x C-k") 'kill-current-buffer)
(global-set-key (kbd "C-x c") 'compile)
(global-set-key (kbd "C-x h") 'view-url)
(global-set-key (kbd "C-x !") 'shell)

;; SCITE like
;(global-set-key [f7] 'split-window-vertically)
;(global-set-key [f8] 'delete-other-windows)
;(global-set-key [f9] 'split-window-horizontally)


(setq default-frame-alist '((vertical-scroll-bars . nil)
                            (tool-bar-lines . 0)
                            (menu-bar-lines . 0)
                            (fullscreen . nil)))
;; Do not blink
(blink-cursor-mode -1)

;; Set path to dependencies

(defvar myPackages
  '(
    ;ein
    ;ace-jump
                                        ; python-
    htmlize
                                        ;flycheck
                                        ;company-racer
                                        ;racer
                                        ;flycheck-rust
    ace-jump-mode
    pyenv-mode-auto
                                      ; company-jedi
                                      ; wcheck-mode
    ))

;(mapc #'(lambda (package)
;    (unless (package-installed-p package)
;      (package-install package)))
;      myPackages)



;; PYTHON CONFIGURATION
;; --------------------------------------

;; enable autopep8 formatting on save


(use-package helm
  :config
  (require 'helm-config)
  (helm-mode 1)
  (define-key global-map [remap find-file] 'helm-find-files)
  (define-key global-map [remap occur] 'helm-occur)
  (define-key global-map [remap list-buffers] 'helm-buffers-list)
  (define-key global-map [remap dabbrev-expand] 'helm-dabbrev)
  (global-set-key (kbd "M-x") 'helm-M-x)
  (unless (boundp 'completion-in-region-function)
    (define-key lisp-interaction-mode-map [remap completion-at-point] 'helm-lisp-completion-at-point)
    (define-key emacs-lisp-mode-map       [remap completion-at-point] 'helm-lisp-completion-at-point))
  (global-set-key (kbd "C-x C-d") 'helm-browse-project)
  )

(use-package helm-ls-git
  :config
  (global-set-key (kbd "C-<f7>") 'helm-ls-git-ls)
  )

(use-package helm-ispell)
;(use-package helm-git)
(use-package helm-ag)
(use-package helm-company
  :config
  (define-key company-mode-map (kbd "C-:") 'helm-company)
  (define-key company-active-map (kbd "C-:") 'helm-company)
  )

(use-package helm-pydoc
  :config
  (define-key python-mode-map (kbd "C-c C-d") 'helm-pydoc))
(use-package helm-themes)


(use-package cursor-chg
  :config
  (setq curchg-default-cursor-color "LightSkyBlue1")
  (setq curchg-input-method-cursor-color "red")
  (setq curchg-default-cursor-type '(hbar . 7))
  (change-cursor-mode 1) ; On for overwrite/read-only/input mode
  (toggle-cursor-type-when-idle 1) ; On when idle
  )

(require 'linum+)
(defun linum-update-window-scale-fix (win)
  "fix linum for scaled text"
  (set-window-margins win
                      (ceiling (* (if (boundp 'text-scale-mode-step)
                                      (expt text-scale-mode-step
                                            text-scale-mode-amount) 1)
                                  (if (car (window-margins))
                                      (car (window-margins)) 1)
                                  ))))

(autoload 'run-prolog "prolog" "Start a Prolog sub-process." t)
(autoload 'prolog-mode "prolog" "Major mode for editing Prolog programs." t)
(autoload 'mercury-mode "prolog" "Major mode for editing Mercury programs." t)
(setq prolog-system 'swi) ;; swi
(setq auto-mode-alist
      (append '(("\\.pl$" . prolog-mode)
                ("\\.pro$" . prolog-mode)
                ("\\.m$" . mercury-mode)
                ("\\.P$" . prolog-mode)
                ("\\.tex$" . latex-mode)
                )
              auto-mode-alist)
      )

(global-set-key (kbd "C-c q") 'auto-fill-mode)

(autoload 'vala-mode "vala-mode" "Major mode for editing Vala code." t)
(add-to-list 'auto-mode-alist '("\.vala$" . vala-mode))
(add-to-list 'auto-mode-alist '("\.vapi$" . vala-mode))
(add-to-list 'file-coding-system-alist '("\.vala$" . utf-8))
(add-to-list 'file-coding-system-alist '("\.vapi$" . utf-8))


(global-set-key "\C-x\ \C-r" 'recentf-open-files)


(if
    windowed-system
    (progn
      (mouse-wheel-mode t)
      (global-font-lock-mode t)
      (setq font-lock-maximum-decoration t)
      )
  (progn
    )
  )

(setq-default
 default-truncate-lines t
 ; blink-cursor-alist '((t . hollow))
 user-full-name "Evgeny Cherkashin"
 user-mail-address "eugeneai@irnok.net"
 column-number-mode t
 line-number-mode t
 page-delimiter "^\\s *\n\\s *"
 minibuffer-max-depth nil
 display-time-day-and-date t
 frame-title-format '(buffer-file-name "%f" "%b")
 )

;;; Stefan Monnier <foo at acm.org>. It is the opposite of fill-paragraph
(defun unfill-paragraph ()
  "Takes a multi-line paragraph and makes it into a single line of text."
  (interactive)
  (let ((fill-column (point-max)))
    (fill-paragraph nil)))

(defun reconstruct-paragraph ()
  "Takes a multi-line paragraph and makes it into a single line of text."
  (interactive)
  (let ((fill-column (point-max)))
    (fill-paragraph nil)
    )
  (replace-regexp "\\(\\w+\\)-\\s-+\\(\\w+\\)" "\\1\\2" nil (line-beginning-position) (line-end-position))
  (replace-regexp "\\s-*вЂ\”" "~--" nil (line-beginning-position) (line-end-position))
  (replace-regexp "\\s—" "~--" nil (line-beginning-position) (line-end-position))
  (replace-regexp "\\(\\w+\\)-\\(\\w+\\)" "\\1\"=\\2" nil (line-beginning-position) (line-end-position))
  (replace-regexp "\\.\\.\\." "\\\\ldots{}" nil (line-beginning-position) (line-end-position))
  (replace-regexp "\\[\\([[:digit:]]+\\)\\]" "\\\\cite{b\\1}" nil (line-beginning-position) (line-end-position))
  ;(replace-regexp "\\(\\w\\|\\.\\):" "\\1\\\\,:" nil (line-beginning-position) (line-end-position))
  (replace-regexp "\\([тТ]\\.\\)\\s-*\\(\\w\\.\\)" "\\1~\\2" nil (line-beginning-position) (line-end-position))
  (replace-regexp "\\([[:upper:]]\\.\\)\\s-*\\([[:upper:]]\\.\\)\\s-+\\([[:upper:]]\\w*\\)" "\\1~\\2~\\3" nil (line-beginning-position) (line-end-position))
  (replace-regexp "\\([[:upper:]]\\.\\)\\s-+\\([[:upper:]]\\w*\\)" "\\1~\\2" nil (line-beginning-position) (line-end-position))
  ;(replace-regexp "\"\\(\\w+\\)" "<<\1" nil (line-beginning-position) (line-end-position))
  ;(replace-regexp "\\(\\w+\\)\"" "\1>>" nil (line-beginning-position) (line-end-position))
  ;(replace-regexp "\"\\(\\.\\)\"" "<<\1>>" nil (line-beginning-position) (line-end-position))
  ;(replace-regexp "\\s-+" "_")
  )

(defun reconstruct-minted ()
  "From cursor till '\end{' performs text cleaning."
  (interactive)
  (let ((endpos (point)))
    (save-excursion
      (goto-char (mark))
      (beginning-of-line)
      (while (< (point) endpos)
        ;; (funcall fun (buffer-substring (line-beginning-position) (line-end-position)))
        (reconstruct-minted-line)
        )
      )
    )
  )

(defun reconstruct-minted-line ()
  (interactive)
  (beginning-of-line)
  (replace-regexp "\\\\textquotedbl{}" "\"" nil (line-beginning-position) (line-end-position))
  (replace-regexp "#doctest:.*$" "" nil (line-beginning-position) (line-end-position))
  (replace-regexp "^\\.\\.\\." "   " nil (line-beginning-position) (line-end-position))
  (replace-regexp "\\~" " " nil (line-beginning-position) (line-end-position))
  (replace-regexp "\\\\" "" nil (line-beginning-position) (line-end-position))
  (replace-regexp "{\\[}" "[" nil (line-beginning-position) (line-end-position))
  (replace-regexp "{\\]}" "]" nil (line-beginning-position) (line-end-position))
  (forward-line 1)
  ; #doctest: +ELLIPSIS
  )

;; Handy key definition
(define-key global-map [f9] 'reconstruct-paragraph)
(define-key global-map [f12] 'reconstruct-minted-line)
(define-key global-map [f4] 'delete-other-windows)

(add-to-list 'auto-mode-alist '("\\.zcml\\'" . xml-mode))
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))

;;;;; key bindings

(global-set-key (kbd "C-x e") 'erase-buffer)
(global-set-key (kbd "C-<escape>") 'keyboard-escape-quit)
(global-unset-key (kbd "<escape>-<escape>-<escape>"))
(global-set-key (kbd "C-q") 'quoted-insert)
(global-set-key (kbd "C-z") 'undo)

(global-set-key (kbd "s-<right>") 'next-buffer)
(global-set-key (kbd "s-<left>") 'previous-buffer)
(global-set-key (kbd "C-<return>") 'open-next-line)



(add-to-list 'safe-local-variable-values '(lexical-binding . t))
(add-to-list 'safe-local-variable-values '(whitespace-line-column . 80))

(set-default 'indent-tabs-mode nil)
(set-default 'indicate-empty-lines t)
(set-default 'imenu-auto-rescan nil)


;defalias 'yes-or-no-p 'y-or-n-p)
(random t) ;; Seed the random-number generator

(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(ansi-color-for-comint-mode-on)

(global-set-key [C-f1] 'bookmark-set)
(global-set-key [f1] 'bookmark-jump)

;; Strange colous

(setq inhibit-startup-message   t)   ; Don't want any startup message

;(require 'highlight-indentation)
;(add-hook 'python-mode-hook 'highlight-indentation)
(add-hook 'python-mode-hook (lambda ()
                              (setq skeleton-pair nil)
                                        ;(local-set-key [f5] 'spacemacs/python-execute-file)
                              (local-set-key [f5] 'elpy-shell-send-region-or-buffer)
                                        ;(local-set-key [f6] 'spacemacs/python-execute-file-focus)
                              ))

;;; Set some more

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(defun annotate-pdb ()
  (interactive)
  (highlight-lines-matching-regexp "import pu?db")
  (highlight-lines-matching-regexp "pdb.set_trace()"))
(add-hook 'python-mode-hook 'annotate-pdb)

(defun python-add-breakpoint ()
  (interactive)
  (newline-and-indent)
  (insert "import pdb; pdb.set_trace()")
  (newline-and-indent)
  (highlight-lines-matching-regexp "^[ ]*import pdb; pdb.set_trace()"))

(defun python-add-pubreakpoint ()
  (interactive)
  (newline-and-indent)
  (insert "import pudb; pu.db")
  (newline-and-indent)
  (highlight-lines-matching-regexp "^[ ]*import pudb; pu.db"))

(add-hook 'python-mode-hook '(lambda () (define-key python-mode-map (kbd "C-c C-t") 'python-add-breakpoint)))
(add-hook 'python-mode-hook '(lambda () (define-key python-mode-map (kbd "C-c C-y") 'python-add-pubreakpoint)))

(add-hook 'python-mode-hook '(lambda ()
                               (electric-indent-local-mode -1)
                               ))

(defun tex-add-russian-dash ()
  (interactive)
  (insert "~-- "))

(add-hook 'late-mode-hook (lambda ()
                            (local-set-key (kbd "C-=") #'tex-add-russian-dash)
                            (local-set-key (kbd "C-c C-=") 'tex-add-verb-environment))

          )

(defun tex-add-verb-environment ()
  (interactive)
  (open-next-line 1)
  (insert "{\\tt%")
  (open-next-line 1)(beginning-of-line)
  (insert "\\begin{verbatim}")
  (open-next-line 1)
  (open-next-line 1)
  (insert "\\end{verbatim}%")
  (open-next-line 1)(beginning-of-line)
  (insert "}%")
  (backward-char 2)
  (forward-line -2)
  )

(defun my-ttt ()
  (erase-buffer)
  (face-remap-add-relative 'default '(
          ; :family "Monospace"
          ; :height 160 ;Seseg
           :height 100
          ))
)

(add-hook 'comint-mode-hook 'my-ttt)
(add-hook 'compilation-mode-hook 'my-ttt)
(add-hook 'gdb-locals-mode-hook 'my-ttt)
(add-hook 'gdb-frames-mode-hook 'my-ttt)
(add-hook 'gdb-registers-mode-hook 'my-ttt)


;; vala
(autoload 'vala-mode "vala-mode" "Major mode for editing Vala code." t)
(add-to-list 'auto-mode-alist '("\\.vala$" . vala-mode))
(add-to-list 'auto-mode-alist '("\\.vapi$" . vala-mode))
(add-to-list 'file-coding-system-alist '("\\.vala$" . utf-8))
(add-to-list 'file-coding-system-alist '("\\.vapi$" . utf-8))

;(load custom-file)

(defun set-input-method-english ()
  (interactive)
  (if current-input-method (toggle-input-method))
  )

(defun latex-b-slash ()
  (interactive)
  (set-input-method-english)
  (insert "\\")
)

;; (set-background-color        "wheat3") ; Set emacs bg color

;;(toggle-fullscreen)

;; Adjust line number fonts.

(defun dollar-equation ()
  (interactive)
  (set-input-method-english)
  (insert "$$")
  (backward-char)
  (set-input-method-english)
)

(defun latex-dollar-hack ()
  (interactive)
  (local-set-key (kbd "C-4") 'dollar-equation)
  )

(defun turn-off-auto-fill ()
  (interactive)
  (auto-fill-mode 0)
  )

(add-hook 'text-mode-hook 'turn-off-auto-fill)
;(add-hook 'text-mode-hook 'turn-on-flyspell)

(add-hook 'text-mode-hook 'turn-on-visual-line-mode)
(add-hook 'diff-mode-hook 'turn-on-visual-line-mode)
(add-hook 'latex-mode-hook 'turn-off-auto-fill)
(add-hook 'latex-mode-hook 'turn-on-visual-line-mode)

(defun latex-12-hacks ()
  (latex-dollar-hack)
  ; (add-hook 'post-command-hook 'auto-language-environment)
  )

(global-set-key (kbd "C-`") 'linum-mode)
(put 'scroll-left 'disabled nil)

;; Patching wrong scrolllock behaviour
(defun scroll-lock-next-line (&optional arg)
  "Scroll up ARG lines keeping point fixed."
  (interactive "p")
  (or arg (setq arg 1))
  (scroll-lock-update-goal-column)
  (if (pos-visible-in-window-p (point-max))
      (progn
        (next-line arg)
        (print "vis-p")
        (print arg)
      )
    (progn
      (scroll-up arg)
      (next-line (- arg))
      (print arg)
      (print "not-vis-p")
      )
    )
  (scroll-lock-move-to-column scroll-lock-temporary-goal-column)
  )

(defvar gud-overlay
(let* ((ov (make-overlay (point-min) (point-min))))
(overlay-put ov 'face 'secondary-selection)
ov)
"Overlay variable for GUD highlighting.")

(defadvice gud-display-line (after my-gud-highlight act)
"Highlight current line."
(let* ((ov gud-overlay)
(bf (gud-find-file true-file)))
(save-excursion
  (set-buffer bf)
  (move-overlay ov (line-beginning-position) (line-end-position)
  (current-buffer)))))

(defun gud-kill-buffer ()
(if (eq major-mode 'gud-mode)
(delete-overlay gud-overlay)))

(add-hook 'kill-buffer-hook 'gud-kill-buffer)
(add-hook 'gdb-mode-hook '(lambda ()
                            ;(new-frame)
                            ;(switch-to-buffer "**gdb**")
                            ;(tool-bar-mode 1)
                            (gdb-many-windows)
                            ))
;;-------------------------------------------------------------

(put 'erase-buffer 'disabled nil)

;; Some additional features

; ########### HUNSPELL in EMACS ########################

;; список используемых нами словарей
(setq ispell-local-dictionary-alist
      '(("russian"
         "[АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЬЫЪЭЮЯабвгдеёжзийклмнопрстуфхцчшщьыъэюя]"
         "[^АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЬЫЪЭЮЯабвгдеёжзийклмнопрстуфхцчшщьыъэюя]"
         "[-]"  nil ("-d" "ru_RU") nil utf-8)
        ("english"
         "[A-Za-z]" "[^A-Za-z]"
         "[']"  nil ("-d" "en_US") nil iso-8859-1)))

;; вместо aspell использовать hunspell
(setq ispell-really-aspell nil
      ispell-really-hunspell t
      ispell-dictionary "english")

(setq ispell-program-name "/usr/local/bin/hunspell")

;; ;(require 'ispell)

(defun fd-switch-dictionary()
  (interactive)
  (let* ((dic ispell-current-dictionary)
         (change (if (string= dic "russian") "english" "russian")))
    (ispell-change-dictionary change)
    (message "Dictionary switched from %s to %s" dic change)
    ))

(global-set-key (kbd "<f8>")   'fd-switch-dictionary)

;; ;; полный путь к нашему пропатченному hunspell
;; ;;(setq ispell-program-name "/usr/bin/hunspell")

;(load "enchant.el")

(if (eq window-system 'w32)
    (progn
      (custom-set-variables
       '(rw-hunspell-dicpath-list (quote ("c:/GNU/share/hunspell")))
       )
      )
  )

(autoload
  'ace-jump-mode
  "ace-jump-mode"
  "Emacs quick move minor mode"
  t)

(define-key global-map (kbd "M-SPC") 'ace-jump-mode)

;; Save point position between sessions
(require 'saveplace)
(setq-default save-place t)
(setq save-place-file (expand-file-name ".places" user-emacs-directory))


(setq ring-bell-function
      (lambda ()
        (unless (memq this-command
                      '(isearch-abort abort-recursive-edit exit-minibuffer keyboard-quit))
          (ding))))

;(add-hook 'after-init-hook 'spaceline-spacemacs-theme)



; ########### END HUNSPELL in EMACS ########################







;; init.el ends here

  ;;(add-to-list 'company-backends 'company-jedi)


  ;; (add-hook 'LaTeX-mode-hook 'turn-on-visual-line-mode)

  ;(add-hook 'python-mode-hook 'jedi-mode)
  ;; (setq reftex-plug-into-AUCTeX t)

  ;; (setq curchg-default-cursor-color "LightSkyBlue1")
  ;; (setq curchg-input-method-cursor-color "red")
  ;; (setq curchg-default-cursor-type '(hbar . 5))
  ;; (change-cursor-mode 1) ; On for overwrite/read-only/input mode
  ;; (toggle-cursor-type-when-idle 1) ; On when idle

;; That's need to be here
(require 'open-next-line)
(global-set-key (kbd "C-j") 'newline-and-indent)
(global-set-key (kbd "RET") 'newline-and-indent)
(defalias 'qrr 'query-replace-regexp)

(provide 'init)
;;; init.el ends here
