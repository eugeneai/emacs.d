;;; Configuration --- Summary
;;; Commentary:
;; This is configuration for Emacs.
;;; Code:
;; init.el --- Emacs configuration


;; Consider using abbreviations.
(add-hook 'text-mode-hook (lambda () (abbrev-mode 1)))
(setq abbrev-file-name             ;; tell emacs where to read abbrev
      "~/.emacs.d/private/abbrev_defs")    ;; definitions from...
; (write-abbrev-file)
(setq save-abbrevs 'silently)
;; you will be asked before the abbreviations are saved

(setq debug-on-error nil)

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


(setenv "WORKON_HOME" "~/.pyenv/versions")

;(global-linum-mode t) ;; enable line numbers globally


;; If async is installed
(add-to-list 'load-path "~/.emacs.d/site-lisp")
(add-to-list 'load-path "~/.emacs.d/private")
(add-to-list 'load-path "~/.emacs.d/site-lisp/helm")
(add-to-list 'load-path "~/.emacs.d/site-lisp/async")

;(setq dotfiles-dir (expand-file-name "~/.emacs.d/"))
;(setq site-lisp-dir (expand-file-name "site-lisp" dotfiles-dir))
;(add-to-list 'load-path site-lisp-dir)


;(load-theme 'eugeneai-theme t)


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
                         ;("marmalade" . "http://marmalade-repo.org/packages/")
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
(when (fboundp 'windmove-default-keybindings)
                                        ;(windmove-default-keybindings)
  (global-set-key (kbd "C-c <left>")  'windmove-left)
  (global-set-key (kbd "C-c <right>") 'windmove-right)
  (global-set-key (kbd "C-c <up>")    'windmove-up)
  (global-set-key (kbd "C-c <down>")  'windmove-down)
  (global-set-key (kbd "C-x <left>")  'windmove-left)
  (global-set-key (kbd "C-x <right>") 'windmove-right)
  (global-set-key (kbd "C-x <up>")    'windmove-up)
  (global-set-key (kbd "C-x <down>")  'windmove-down)
  )

;; Use Mac keys:
(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'super)
(setq ns-function-modifier 'hyper)


;; Jump easily to beginning and end.
(global-set-key (kbd "C-|") 'beginning-of-buffer)
(global-set-key (kbd "C-}") 'end-of-buffer)

;; Easily memorable whole-buffer selection.
(global-set-key (kbd "M-A") 'mark-whole-buffer)

(use-package nlinum
  :bind
  ("C-`" . nlinum-mode))

;; Easily turn line numbers on and off.
; (global-set-key (kbd "C-`") 'nlinum-mode)

;; switch point into buffer list
(global-set-key (kbd "C-x C-b") 'buffer-menu)

;; dired at point is nice
(global-set-key (kbd "C-x C-j") 'dired-at-point)



;; Make C-h and M-h backspace; move help to C-x h.
;; (On some systems, C-h already sends DEL.)
;(global-set-key (kbd "C-x h") 'help-command)



;; INSTALL PACKAGES
;; --------------------------------------

(use-package better-defaults)

;; Highlight where matching parens are.
(show-paren-mode t)
(setq show-paren-style 'expression)
(electric-pair-mode nil)
(delete-selection-mode t)
(setq redisplay-dont-pause t)
(fringe-mode '(8 . 0))
(setq-default indicate-buffer-boundaries 'left)
(setq display-time-24hr-format t)
(setq scroll-step 1)
(setq scroll-margin 3)
(setq scroll-conservatively 10000)
(defalias 'yes-or-no-p 'y-or-n-p)
(setq x-select-enable-clipboard t)

;; make cursor movement keys under right hand's home-row.
(global-set-key (kbd "M-j") 'backward-char) ; was indent-new-comment-line
(global-set-key (kbd "M-l") 'forward-char)  ; was downcase-word
(global-set-key (kbd "M-i") 'previous-line) ; was tab-to-tab-stop
(global-set-key (kbd "M-k") 'next-line) ; was kill-sentence

(use-package ergoemacs-mode
  :disabled 1
  :config
  ;(setq ergoemacs-theme nil) ;; Uses Standard Ergoemacs keyboard theme
  ;(setq ergoemacs-keyboard-layout "us") ;; Assumes QWERTY keyboard layout
  ;(ergoemacs-mode 1)
  )

(use-package ag
  :defer t)


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
  (define-key smartparens-mode-map (kbd "C-M-c") 'sp-copy-sexp)
  (define-key smartparens-mode-map (kbd "C-M-[") 'sp-rewrap-sexp)
  (define-key smartparens-mode-map (kbd "C-M-]") 'sp-backward-unwrap-sexp)
  (define-key smartparens-mode-map (kbd "C-M-z") 'sp-slurp-hybrid-sexp)
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
  (show-smartparens-mode 1)
  :diminish smartparens-mode)


;; Move things around intuitively.
(use-package drag-stuff
  :config
  (drag-stuff-global-mode)
  (drag-stuff-define-keys)
  :diminish drag-stuff-mode)


;; expand-region is that new hotness.
(use-package expand-region
  :bind
  ("M-p" . er/expand-region))


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
  ;:disabled t
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
  :if (executable-find "git")
  :bind
  ("C-x g" . magit-status)
  ;:commands
  ;(magit-status)
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
  :commands
  (magit-after-save-refresh-status
   magit-filenotify-mode)
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
  :commands
  (projectile-find-file)
  :config
  (projectile-global-mode)
  (global-set-key (kbd "C-<f6>") 'projectile-find-file)
  :diminish projectile-mode
  )
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
  :bind (:map flycheck-mode-map
              ("M-RET f n" . flycheck-next-error)
              ("M-RET f p" . flycheck-previous-error)
              )
  :diminish flycheck-mode
  )

(use-package company
  :config
  (add-hook 'after-init-hook 'global-company-mode)
  (setq company-idle-delay 0.2)
  (setq company-tooltip-limit 10)
  (setq company-minimum-prefix-length 2)
  ;; invert the navigation direction if the the completion popup-isearch-match
  ;; is displayed on top (happens near the bottom of windows)
  (setq company-tooltip-flip-when-above t)
  )

;; Elpy the Emacs Lisp Python Environment.
(use-package elpy
  :config
  (progn
    (elpy-enable)
    ;; Use ipython if available.
                                        ;(when (executable-find "ipython")
                                        ;  (elpy-use-ipython))
    ;; Don't use flymake if flycheck is available.
    ;; (when (require 'flycheck nil t)
    ;;   (setq elpy-modules
    ;;         (delq 'elpy-module-flymake elpy-modules))
    ;;   (add-hook 'elpy-mode-hook 'flycheck-mode))

    ;; (setq elpy-modules '(elpy-module-sane-defaults
    ;;                      elpy-module-company
    ;;                      elpy-module-eldoc
    ;;                      elpy-module-highlight-indentation
    ;;                      elpy-module-pyvenv
    ;;                      elpy-module-yasnippet))

    ;(delq 'elpy-module-flymake elpy-modules)
    (add-hook 'python-mode-hook
              (lambda ()
                (set (make-local-variable 'comment-inline-offset) 2)
                (auto-complete-mode -1)))

    ;; Don't use highlight-indentation-mode.
    (delete 'elpy-module-highlight-indentation elpy-modules)
    ;; this is messed with by emacs if you let it...
    (custom-set-variables
     ;'(elpy-rpc-backend "jedi")
     '(help-at-pt-display-when-idle (quote (flymake-overlay)) nil (help-at-pt))
     '(help-at-pt-timer-delay 1.9)
     '(tab-width 4))
    ;; Elpy also installs yasnippets.
    ;; Don't use tab for yasnippets, use shift-tab.
    (define-key yas-minor-mode-map (kbd "<tab>") nil)
    (define-key yas-minor-mode-map (kbd "TAB") nil)
    (define-key yas-minor-mode-map (kbd "<backtab>") 'yas-expand)
    (defalias 'workon 'pyenv-workon)
    (pyvenv-workon "elpy")
    (add-hook 'elpy-mode-hook (lambda ()
                                (electric-pair-mode nil)))
    )
  :mode (("\\.py\\'" . elpy-mode))
  :bind (:map elpy-mode-map
              ("M-RET f c" . elpy-format-code)
              ("M-RET e n" . next-error)
              ("M-RET e p" . previous-error)
              )
  )

(use-package py-autopep8
  :config
  (add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)
  )

(use-package nose
  :after elpy
  :commands (nosetests-one
             nosetests-pdb-one
             nosetests-all
             nosetests-pdb-all
             nosetests-module
             nosetests-pdb-module
             nosetests-suite
             nosetests-pdb-suite)
  :init
  :config
  (progn
    (add-to-list 'nose-project-root-files "setup.cfg")
    (setq nose-use-verbose nil))
  :bind
  (:map elpy-mode-map
        ("M-RET t a" . nosetests-all-virtualenv)
        ("<XF86Calculator>" . nosetests-all)
        )
  )

(use-package pyenv-mode
  :if (executable-find "pyenv")
  ;:defer t
  ;:after elpy
  :config
  ;(add-hook 'elpy-mode-hook (lambda () (pyenv-mode 1)))
  (add-hook 'elpy-mode-hook (lambda () (pyenv-mode 1)))
  (require 'pyenv-mode-auto)
  )

;; (use-package pyenv-mode-auto
;;   :if (executable-find "pyenv")
;;   ;:defer t
;;   :after pyenv-mode
;;   :config
;;   ;(add-hook 'find-file-hook 'pyenv-mode-auto-hook)
;;   )

;; Emacs Speaks Statistics includes support for R.
(use-package ess-site
  :ensure ess)


;; Use a nice JavaScript mode.
(use-package js2-mode
  :mode
  (("\\.js\\'" . js2-mode)
  ))

(use-package paredit
  :disabled 1
  :diminish paredit-mode
  :after elpy
  :config
  (add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
  (add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
  (add-hook 'ielm-mode-hook             #'enable-paredit-mode)
  (add-hook 'lisp-mode-hook             #'enable-paredit-mode)
  (add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
  (add-hook 'scheme-mode-hook           #'enable-paredit-mode)
  (add-hook 'prog-mode-hook             #'enable-paredit-mode)
  ;(add-hook 'elpy-mode-hook             #'enable-paredit-mode)
  ; :bind (("C-c d" . paredit-forward-down))
  )

;; Ensure paredit is used EVERYWHERE!
(use-package paredit-everywhere
  :disabled
  :diminish paredit-everywhere-mode
  :config
  (add-hook 'prog-mode-hook #'paredit-everywhere-mode)
  (add-hook 'elpy-mode-hook #'paredit-everywhere-mode)
  )

(use-package highlight-parentheses
  :diminish highlight-parentheses-mode
  :config
  (add-hook 'emacs-lisp-mode-hook
            (lambda()
              (highlight-parentheses-mode)
              )))

(global-highlight-parentheses-mode)

;; Support markdown, for goodness sake.
(use-package markdown-mode
  :defer t
  :config
  (define-key markdown-mode-map (kbd "M-n") nil)
  (define-key markdown-mode-map (kbd "M-p") nil))

(use-package markdown-mode+
  :defer t
  :after markdown-mode
  )

(use-package pandoc-mode
  :defer t
  :if (executable-find "pandoc")
  :config
  (add-hook 'markdown-mode-hook 'pandoc-mode)
  )

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
  :defer t
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
  :defer t
  :after tex
  :config
  (auctex-latexmk-setup)
  )

(use-package slime
  :config
  ;; the SBCL configuration file is in Common Lisp
  (add-to-list 'auto-mode-alist '("\\.sbclrc\\'" . lisp-mode))
  ;; Open files with .cl extension in lisp-mode
  (add-to-list 'auto-mode-alist '("\\.cl\\'" . lisp-mode))
  ;; Add fancy slime contribs
  (setq slime-contribs '(slime-fancy))
  ;; rainbow-delimeters messes up colors in slime-repl, and doesn't seem to work
  ;; anyway, so we won't use prelude-lisp-coding-defaults.
  (add-hook 'slime-repl-mode-hook (lambda ()
                                    (smartparens-strict-mode +1)
                                    (whitespace-mode -1)))
  (setq slime-complete-symbol-function 'slime-fuzzy-complete-symbol
        slime-fuzzy-completion-in-place t
        slime-enable-evaluate-in-emacs t
        slime-autodoc-use-multiline-p t
        inferior-lisp-program "sbcl"
        slime-auto-start 'always)
  (define-key slime-mode-map (kbd "TAB") 'slime-indent-and-complete-symbol)
  (define-key slime-mode-map (kbd "C-c C-s") 'slime-selector)
  )

;; Scheme support
(use-package geiser
  :defer 1
  :config
  ;(setq scheme-program-name "csi -:c")
  ;(define-key scheme-mode-map "\C-c\C-l" 'scheme-load-current-file)
  ;(define-key scheme-mode-map "\C-c\C-k" 'scheme-compile-current-file)

  (require 'cmuscheme)

  ;(define-key scheme-mode-map "\C-c\C-l" 'scheme-load-current-file)
  ;(define-key scheme-mode-map "\C-c\C-k" 'scheme-compile-current-file)

  (defun scheme-load-current-file (&optional switch)
    (interactive "P")
    (let ((file-name (buffer-file-name)))
      (comint-check-source file-name)
      (setq scheme-prev-l/c-dir/file (cons (file-name-directory    file-name)
                                           (file-name-nondirectory file-name)))
      (comint-send-string (scheme-proc) (concat "(load \""
                                                file-name
                                                "\"\)\n"))
      (if switch
          (switch-to-scheme t)
        (message "\"%s\" loaded." file-name) ) ) )

  (defun scheme-compile-current-file (&optional switch)
    (interactive "P")
    (let ((file-name (buffer-file-name)))
      (comint-check-source file-name)
      (setq scheme-prev-l/c-dir/file (cons (file-name-directory    file-name)
                                           (file-name-nondirectory file-name)))
      (message "compiling \"%s\" ..." file-name)
      (comint-send-string (scheme-proc) (concat "(compile-file \""
                                                file-name
                                                "\"\)\n"))
      (if switch
          (switch-to-scheme t)
        (message "\"%s\" compiled and loaded." file-name) ) ) )
  ;; Indenting module body code at column 0
  (defun scheme-module-indent (state indent-point normal-indent) 0)
  (put 'module 'scheme-indent-function 'scheme-module-indent)

  (put 'and-let* 'scheme-indent-function 1)
  (put 'parameterize 'scheme-indent-function 1)
  (put 'handle-exceptions 'scheme-indent-function 1)
  (put 'when 'scheme-indent-function 1)
  (put 'unless 'scheme-indent-function 1)
  (put 'match 'scheme-indent-function 1)
  (require 'autoinsert)
  (add-hook 'find-file-hooks 'auto-insert)

  (setq auto-insert-alist
        '(("\\.scm" .
           (insert "#!/bin/sh\n#| -*- scheme -*-\nexec csi -s $0 \"$@\"\n|#\n"))))
  )

(use-package css-mode
  :defer t
  :init
  (progn
    ;; Mark `css-indent-offset' as safe-local variable
    (put 'css-indent-offset 'safe-local-variable #'integerp)
    ;; Explicitly run prog-mode hooks since css-mode does not derive from
    ;; prog-mode major-mode in Emacs 24 and below.
    (when (version< emacs-version "25")
      (add-hook 'css-mode-hook 'spacemacs/run-prog-mode-hooks))
    (defun css-expand-statement ()
      "Expand CSS block"
      (interactive)
      (save-excursion
        (end-of-line)
        (search-backward "{")
        (forward-char 1)
        (while (or (eobp) (not (looking-at "}")))
          (let ((beg (point)))
            (newline)
            (search-forward ";")
            (indent-region beg (point))
            ))
        (newline)))
    (defun css-contract-statement ()
      "Contract CSS block"
      (interactive)
      (end-of-line)
      (search-backward "{")
      (while (not (looking-at "}"))
        (join-line -1)))
    )
  :config
  (require 'company-css)
  )

(use-package company-web
  :defer t)

(use-package web-mode
  :defer t
  :after company-web
  :config
  (require 'company-web-html)
  (require 'company-css)
  (add-hook 'html-mode-hook 'visual-line-mode)
  (add-hook 'web-mode-hook 'visual-line-mode)
  (defun web-mode-flyspefll-verify ()
    (let ((f (get-text-property (- (point) 1) 'face)))
      (not (memq f '(web-mode-html-attr-value-face
                     web-mode-html-tag-face
                     web-mode-html-attr-name-face
                     web-mode-doctype-face
                     web-mode-keyword-face
                     web-mode-function-name-face
                     web-mode-variable-name-face
                     web-mode-css-property-name-face
                     web-mode-css-selector-face
                     web-mode-css-color-face
                     web-mode-type-face
                     )
                 ))))
  (put 'web-mode 'flyspell-mode-predicate 'web-mode-flyspefll-verify)

  (add-hook 'web-mode-hook
            (lambda ()
              (flyspell-mode 1)
              ))
  :mode
  (("\\.phtml\\'"      . web-mode)
   ("\\.tpl\\.php\\'"  . web-mode)
   ("\\.twig\\'"       . web-mode)
   ("\\.x?html\\'"     . web-mode)
   ("\\.x?htm\\'"      . web-mode)
   ("\\.[gj]sp\\'"     . web-mode)
   ("\\.as[cp]x?\\'"   . web-mode)
   ("\\.eex\\'"        . web-mode)
   ("\\.erb\\'"        . web-mode)
   ("\\.mustache\\'"   . web-mode)
   ("\\.handlebars\\'" . web-mode)
   ("\\.hbs\\'"        . web-mode)
   ("\\.eco\\'"        . web-mode)
   ("\\.ejs\\'"        . web-mode)
   ("\\.djhtml\\'"     . web-mode)
   ("\\.pt\\'"         . web-mode)
   ))

;; Inpation mode

(use-package impatient-mode
  )

;;; CONTINUE:
;;; TODO: Other languages

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
  :if (executable-find "w3m")
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
  :bind
  ("C-x M-r" . recentf-open-files)
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

(use-package ace-jump-mode
  :bind
  ("<print> a" . ace-jump-mode)
  )

(use-package avy
  :bind
  ("<print> c" . avy-goto-char)
  ("<print> w" . avy-goto-word-1)
  ("<print> l" . avy-goto-line)
  )

(use-package anzu
  :config
  (global-anzu-mode)
  :diminish anzu-mode
  :bind
  ("M-%" . anzu-query-replace)
  ("C-M-%" . anzu-query-replace-regexp)
  )

(use-package htmlize
  :commands
  (htmlize-buffer
   htmlfontify-buffer)
  :after rainbow-delimiters
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
  (global-set-key (kbd "<f4>")   'fd-switch-dictionary)
  (add-hook 'text-mode-hook (lambda ()
                              (flyspell-mode)
                              (diminish 'flyspell-mode)))
  (add-hook 'prog-mode-hook (lambda ()
                              (flyspell-prog-mode)
                              (diminish 'flyspell-mode)))
  ; ispell-alternate-dictionary
  )

(use-package smart-mode-line
  :config
  (setq sml/no-confirm-load-theme t)
  ;; delegate theming to the currently active theme
  ;(setq sml/theme nil)
  (setq sml/theme 'dark)
  ;(setq sml/theme 'light)
  ;(setq sml/theme 'respectful)
  (sml/setup)
)


;; show the cursor when moving after big movements in the window
(use-package beacon
  :config
  (beacon-mode +1)
  )

;; show available keybindings after you start typing
(use-package which-key
  :config
  (which-key-mode +1)
  ;(which-key-setup-side-window-right)
  (which-key-setup-side-window-bottom)
  (setq which-key-idle-delay 0.1)
  )

(use-package cask
  )

(use-package eclim
  :disabled 1
  :config
  (add-hook 'java-mode-hook 'eclim-mode)
  :bind
  (:map eclim-mode-map
        ("M-RET p c" . eclim-problems-correct)
        ("M-RET p s" . eclim-problems)
        ("M-RET f d" . eclim-java-find-declaration)
        ("M-RET f r" . eclim-java-find-references)
        ("M-RET r p" . java-refactor-rename-symbol-at-point)
        ("M-RET s d" . eclim-java-show-documentation-for-current-element)
        ("M-RET s h" . eclim-java-hierarchy)
        ("M-RET i o" . eclim-java-import-organize)
                                        ; (eclim-maven-run "compile, run, test")
        ("M-RET m r" . eclim-maven-run)

        ))

(use-package company-emacs-eclim
  :disabled 1
  :config
  (company-emacs-eclim-setup)
  ;; (custom-set-faces
  ;;  ;; ...
  ;;  '(company-preview ((t (:background "black" :foreground "red"))))
  ;;  '(company-preview-common ((t (:foreground "red"))))
  ;;  '(company-preview-search ((t (:inherit company-preview))))
  ;;  '(company-scrollbar-bg ((t (:background "brightwhite"))))
  ;;  '(company-scrollbar-fg ((t (:background "red"))))
  ;;  '(company-template-field ((t (:background "magenta" :foreground "black"))))
  ;;  '(company-tooltip ((t (:background "brightwhite" :foreground "black"))))
  ;;  '(company-tooltip-annotation ((t (:background "brightwhite" :foreground "black"))))
  ;;  '(company-tooltip-annotation-selection ((t (:background "color-253"))))
  ;;  '(company-tooltip-common ((t (:background "brightwhite" :foreground "red"))))
  ;;  '(company-tooltip-common-selection ((t (:background "color-253" :foreground "red"))))
  ;;  '(company-tooltip-mouse ((t (:foreground "black"))))
  ;;  '(company-tooltip-search ((t (:background "brightwhite" :foreground "black"))))
  ;;  '(company-tooltip-selection ((t (:background "color-253" :foreground
  ;;                                               "black"))))
  ;;  ;; ...
  ;;  )
  )

(use-package mvn)

(use-package sr-speedbar
  :bind
  ("s-a" . sr-speedbar-toggle)
  )

(use-package switch-window
  :config
  (setq switch-window-threshold 2)
  :bind
  ("s-z" . switch-window)
  ("C-x o" . switch-window)
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
      size-indication-mode t
      )

(global-auto-revert-mode t)

;; savehist keeps track of some history
(require 'savehist)
(setq savehist-additional-variables
      ;; search entries
      '(search-ring regexp-search-ring)
      ;; save every minute
      savehist-autosave-interval 60
      ;; keep the home clean
      savehist-file "~/.emacs.d/private/savehist.txt")
(savehist-mode +1)

;; bookmarks
(require 'bookmark)
(setq bookmark-default-file "~/.emacs.d/private/bookmarks.txt"
      bookmark-save-flag 1)
(global-set-key (kbd "<f1>") 'bookmark-set)
(global-set-key (kbd "C-<f1>") 'bookmark-jump)
(global-set-key (kbd "M-<f1>") 'bookmark-bmenu-list)

;; highlight the current line
(global-hl-line-mode 0)

(require 'volatile-highlights)
(volatile-highlights-mode t)
(diminish 'volatile-highlights-mode)

;; tramp, for sudo access
(require 'tramp)
;; keep in mind known issues with zsh - see emacs wiki
(setq tramp-default-method "ssh")

(require 'compile)
(setq compilation-ask-about-save nil  ; Just save before compiling
      compilation-always-kill t       ; Just kill old compile processes before
                                        ; starting the new one
      compilation-scroll-output 'first-error ; Automatically scroll to first
                                        ; error
      )

(defun kill-current-buffer ()
  (interactive)
  (kill-buffer (current-buffer)))

(global-set-key (kbd "C-x C-k") 'kill-current-buffer)
(global-set-key (kbd "C-x c") 'compile)
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

(use-package helm
  :config
  (require 'helm-config)
  (helm-mode 1)
  (define-key global-map [remap find-file] 'helm-find-files)
  (define-key global-map [remap occur] 'helm-occur)
  (define-key global-map [remap list-buffers] 'helm-buffers-list)
  (define-key global-map [remap dabbrev-expand] 'helm-dabbrev)
  (global-set-key (kbd "M-x") 'helm-M-x)
                                        ;(global-set-key (kbd "C-x C-m") 'helm-M-x)
  (global-set-key (kbd "M-y") 'helm-show-kill-ring)
  (global-set-key (kbd "C-x b") 'helm-mini)
  (global-set-key (kbd "C-x C-b") 'helm-buffers-list)
  ;(global-set-key (kbd "C-x C-f") 'helm-find-files)
  (global-set-key (kbd "C-h f") 'helm-apropos)
  (global-set-key (kbd "C-h r") 'helm-info-emacs)
  (global-set-key (kbd "C-h C-l") 'helm-locate-library)
  (global-set-key (kbd "C-x C-r") 'helm-recentf)
  (define-key minibuffer-local-map (kbd "C-c C-l") 'helm-minibuffer-history)
  (define-key isearch-mode-map (kbd "C-o") 'helm-occur-from-isearch)
  ;; shell history.
  (define-key shell-mode-map (kbd "C-c C-l") 'helm-comint-input-ring)
  ;; use helm to list eshell history
  (add-hook 'eshell-mode-hook
   #'(lambda ()
       (substitute-key-definition 'eshell-list-history 'helm-eshell-history eshell-mode-map)))
  (substitute-key-definition 'find-tag 'helm-etags-select global-map)
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

(use-package jedi-direx)

(use-package company-jedi
  :config
  (add-to-list 'company-backends 'company-jedi)
  )

(use-package ttl-mode
  :config
  (add-hook 'ttl-mode-hook    ; Turn on font lock when in ttl mode
            'turn-on-font-lock)
  :mode
  (("\\.ttl\\'"      . ttl-mode)
   ("\\.n3\\'"       . ttl-mode)
   )
  )

;; (require 'linum+)
;; (defun linum-update-window-scale-fix (win)
;;   "fix linum for scaled text"
;;   (set-window-margins win
;;                       (ceiling (* (if (boundp 'text-scale-mode-step)
;;                                       (expt text-scale-mode-step
;;                                             text-scale-mode-amount) 1)
;;                                   (if (car (window-margins))
;;                                       (car (window-margins)) 1)
;;                                   ))))

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
(define-key global-map [f8] 'delete-other-windows)

(add-to-list 'auto-mode-alist '("\\.zcml\\'" . xml-mode))
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))

;;;;; key bindings

(global-set-key (kbd "C-x e") 'erase-buffer)
(global-set-key (kbd "C-<escape>") 'keyboard-escape-quit)
(global-unset-key (kbd "<escape>-<escape>-<escape>"))
(global-set-key (kbd "C-q") 'quoted-insert)
(global-set-key (kbd "C-z") 'undo)

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

;(require 'highlight-indentation)
;(add-hook 'python-mode-hook 'highlight-indentation)
(add-hook 'python-mode-hook (lambda ()
                              (setq skeleton-pair nil)
                                        ;(local-set-key [f5] 'spacemacs/python-execute-file)
                              (local-set-key [f5] 'elpy-shell-send-region-or-buffer)
                                        ;(local-set-key [f6] 'spacemacs/python-execute-file-focus)
                              (elpy-mode)
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
  (highlight-lines-matching-regexp "^[ ]*import pdb;"))

(defun python-add-pubreakpoint ()
  (interactive)
  (newline-and-indent)
  (insert "import pudb; pu.db")
  (newline-and-indent)
  (highlight-lines-matching-regexp "^[ ]*import pu?db;"))

(add-hook 'python-mode-hook '(lambda () (define-key python-mode-map (kbd "C-c M-y") 'python-add-breakpoint)))
(add-hook 'python-mode-hook '(lambda () (define-key python-mode-map (kbd "C-c C-y") 'python-add-pubreakpoint)))

(add-hook 'python-mode-hook '(lambda ()
                               (electric-indent-local-mode -1)
                               ))

(defun tex-add-russian-dash ()
  (interactive)
  (insert "~-- "))

(add-hook 'latex-mode-hook (lambda ()
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

;(global-set-key (kbd "C-`") 'linum-mode)
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


;; Save point position between sessions
(require 'saveplace)
(setq-default save-place t)
(setq save-place-file (expand-file-name ".places" user-emacs-directory))


(setq ring-bell-function
      (lambda ()
        (unless (memq this-command
                      '(isearch-abort abort-recursive-edit exit-minibuffer keyboard-quit))
          (ding))))

  ;;(add-to-list 'company-backends 'company-jedi)


  ;(add-hook 'python-mode-hook 'jedi-mode)
  ;; (setq reftex-plug-into-AUCTeX t)

;; That's need to be here
(require 'open-next-line)
(global-set-key (kbd "C-j") 'newline-and-indent)
(global-set-key (kbd "RET") 'newline-and-indent)
(defalias 'qrr 'query-replace-regexp)

(defun beginning-of-line-or-indentation ()
  "move to beginning of line, or indentation"
  (interactive)
  (if (bolp)
      (back-to-indentation)
    (beginning-of-line)))

(global-set-key (kbd "C-a") 'beginning-of-line-or-indentation)

(defun my-package-recompile()
  "Recompile all packages"
  (interactive)
  (byte-recompile-directory "~/.emacs.d/elpa" 0 t))

(delete-other-windows)
(provide 'init)
;;; init.el ends here
(put 'narrow-to-page 'disabled nil)
