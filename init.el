;;; Configuration --- Summary
;;; Commentary:
;; This is configuration for Emacs.
;;; Code:
;; init.el --- Emacs configuration

;; Consider using abbreviations.
; (flyspell-mode t)
(flyspell-mode nil)
(add-hook 'text-mode-hook (lambda () (abbrev-mode 1)))
(setq abbrev-file-name             ;; tell emacs where to read abbrev
      "~/.emacs.d/private/abbrev_defs")    ;; definitions from...
; (write-abbrev-file)
(setq save-abbrevs 'silently)
;; you will be asked before the abbreviations are saved

;; set env var PATH, by appending a new path to existing PATH value
(setenv "PATH"
        (concat
         "/home/eugeneai/.local/bin" path-separator
         "/home/eugeneai/.cabal/bin" path-separator
         "/home/eugeneai/.ghcup/bin" path-separator
         "/home/eugeneai/.nix-profile/bin" path-separator
         "/nix/var/nix/profiles/default/bin" path-separator
         "C:/cygwin/usr/bin" path-separator
         "C:/cygwin/bin" path-separator
         (getenv "PATH")))

;; Fix
;; (defun magit-process-git (destination &rest args))

;; (setq debug-on-error nil)

;; Just a sec - have to clean things up a little!
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(setq inhibit-startup-screen t)

(define-key special-event-map [config-changed-event] 'ignore)

;; (setq custom-file "~/.emacs.d/private/custom.el")
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

(add-to-list 'display-buffer-alist
             '("." nil (reusable-frames . t)))

;; Compilation output
; (setq compilation-scroll-output t)
(setq compilation-scroll-output 'first-error)

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
; (add-to-list 'load-path "~/.emacs.d/site-lisp/helm")
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
                                 ("http" . "titan.cyber:ghbdtnbr@172.27.100.5:4444")
                                 ("https" . "titan.cyber:ghbdtnbr@172.27.100.5:4444")
                                 ("ftp" . "titan.cyber:ghbdtnbr@172.27.100.5:4444")
								 ))

      )
  )

(setq url-http-proxy-basic-auth-storage
      (list (list "172.27.100.5:4444"
                  (cons "titan.cyber"
                        (base64-encode-string "titan.cyber:ghbdtnbr")))))


;; This package called package comes with Emacs.
(require 'package)
;; Turn on packaging.

(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if t "http" "https")))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  ;; (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")) t)
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;; (add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)

  ;; (add-to-list 'package-archives (cons "marmalade" (concat proto "://marmalade-repo.org/packages/")) t)
  ;; (add-to-list 'package-archives (cons "elpa" (concat proto "://elpa.gnu.org/packages/")) t)
  (add-to-list 'package-archives (cons "elpy" (concat proto "://jorgenschaefer.github.io/packages/")) t)
  ;; (add-to-list 'package-archives (cons "org" (concat proto "://orgmode.org/elpa/")) t)
  )

(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))

(package-initialize)

;; From github.com/magnars/.emacs.d:
;; Ensure we have MELPA package awareness.
(unless (file-exists-p "~/.emacs.d/elpa/archives/melpa")
  (package-refresh-contents))

;; From github.com/sachac/.emacs.d:
;; Bootstrap install of use-package,
;; which also installs diminish.
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(unless (package-installed-p 'dininish)
  (package-install 'diminish))
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
(global-set-key (kbd "C-<next>") 'end-of-buffer)
(global-set-key (kbd "C-<prior>") 'beginning-of-buffer)



;; Easily memorable whole-buffer selection.
(global-set-key (kbd "M-A") 'mark-whole-buffer)

(if
    (version< emacs-version "26.0.50")
    (progn
      (use-package nlinum
        :bind
        ("C-`" . nlinum-mode)))
  (progn
    (global-set-key (kbd "C-`") 'display-line-numbers-mode)))

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
(if (fboundp 'fringe-mode) (fringe-mode '(8 . 8)))
(setq-default indicate-buffer-boundaries 'left)
(setq display-time-24hr-format t)
(setq scroll-step 1)
(setq scroll-margin 3)
(setq scroll-conservatively 10000)
(defalias 'yes-or-no-p 'y-or-n-p)
(setq x-select-enable-clipboard t)

(use-package ag
  :defer t)

;; Move things around intuitively.
(use-package drag-stuff
  ; :defer t
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
  ; (load-theme 'zenburn t)
  )

(use-package material-theme
  :disabled t
  :config
  ; (load-theme 'material t)
  )

;; An original method of spacemacs loading
(use-package spacemacs-common
  :disabled t
  :ensure spacemacs-theme
  :config (load-theme 'spacemacs-dark t))


;; Themes can be disabled with disable-theme.


;; Get useful line behaviors when region is not active.
;; Prehack the keymap to save indent-rigidly ; C-x <tab> <- ... ->
(defvar whole-line-or-region-local-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map [remap kill-region] 'whole-line-or-region-kill-region)
    (define-key map [remap kill-ring-save] 'whole-line-or-region-kill-ring-save)
    (define-key map [remap copy-region-as-kill] 'whole-line-or-region-copy-region-as-kill)
    (define-key map [remap delete-region] 'whole-line-or-region-delete-region)
    (define-key map [remap comment-dwim] 'whole-line-or-region-comment-dwim-2)
    (define-key map [remap comment-region] 'whole-line-or-region-comment-region)
    (define-key map [remap uncomment-region] 'whole-line-or-region-uncomment-region)
    ;; (define-key map [remap indent-rigidly-left-to-tab-stop] 'whole-line-or-region-indent-rigidly-left-to-tab-stop)
    ;; (define-key map [remap indent-rigidly-right-to-tab-stop] 'whole-line-or-region-indent-rigidly-right-to-tab-stop)
    ;; (define-key map [remap indent-rigidly-left] 'whole-line-or-region-indent-rigidly-left)
    ;; (define-key map [remap indent-rigidly-right] 'whole-line-or-region-indent-rigidly-right)
    map)
  "Minor mode map for `whole-line-or-region-mode'.")

(use-package whole-line-or-region
  :config (whole-line-or-region-global-mode t)
  :diminish whole-line-or-region-mode)





;; Interactive selection of things.
;; TODO: consider helm instead (see Sacha's config)
;; NOTE: "C-j: Use the current input string verbatim."
;(ido-mode t)
;(ido-everywhere t)
;; ;; disable ido faces to see flx highlights.
(setq ido-enable-flex-matching t)
(setq ido-use-faces nil)
;; ;(global-set-key (kbd "M-l") 'other-window)
;; ;(global-set-key (kbd "C-M-l") 'ido-switch-buffer)

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


(use-package yasnippet
  :defer t
  :config
  (setq yas-snippet-dirs (append yas-snippet-dirs
                                 '("~/.emacs.d/private/snippets")))
  (yas-reload-all)
  (setq yas-prompt-functions
        '(yas-ido-prompt yas-x-prompt yas-completing-prompt))
  (setq yas-wrap-around-region t)

  (yas-global-mode 1)
  (add-hook 'prog-mode-hook #'yas-minor-mode)
  :bind
  ("C-<return>" . yas-expand-from-trigger-key)
  ("C-M-<return>" . yas-expand-from-trigger-key)
  ("M-RET i s" . yas-insert-snippet)
  )

(use-package yasnippet-snippets
  ; :defer t
  :config
  (yas-reload-all))



;; ;; See the undo history and move through it.
;; (use-package undo-tree
;;   :disabled t
;;   :config (global-undo-tree-mode t)
;;   :diminish undo-tree-mode)

;; Add nice project functions for git repos.
(use-package projectile
  :defer t
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
  :defer t
  :bind
  ("M-RET m e" . mc/edit-lines)
  ("M-RET m m" . mc/mark-more-like-this-extended)
  ("C->" . 'mc/mark-next-like-this)
  ("C-<" . 'mc/mark-previous-like-this)
  ("C-c C-<" . 'mc/mark-all-like-this))


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
;; (use-package zoom-frm
;;   :bind
;;   ("C-=" . zoom-in/out)
;;   ("C-+" . zoom-in/out)
;;   ("C--" . zoom-in/out))
(use-package default-text-scale
  :bind
   ("C-=" . default-text-scale-increase)
   ("C-+" . default-text-scale-increase)
   ("C--" . default-text-scale-decrease)
  )

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

(setq langtool-java-classpath
      "/usr/share/languagetool:/usr/share/java/languagetool/*")
(use-package langtool
  :defer t
  :if (executable-find "/usr/bin/languagetool")
  :config
  ;(setq langtool-java-bin "/usr/bin/java")
  ;;;;; (setq langtool-bin "/usr/bin/languagetool")
  ;; (setq langtool-language-tool-jar "/usr/share/java/languagetool/languagetool-commandline.jar")
  ;; (setq langtool-java-classpath
  ;;       "/usr/share/java/languagetool/*")
  (setq langtool-default-language "ru-RU")
  (setq langtool-mother-tongue "ru")
  (defun langtool-autoshow-detail-popup (overlays)
    (when (require 'popup nil t)
      ;; Do not interrupt current popup
      (unless (or popup-instances
                  ;; suppress popup after type `C-g' .
                  (memq last-command '(keyboard-quit)))
        (let ((msg (langtool-details-error-message overlays)))
          (popup-tip msg)))))

  (setq langtool-autoshow-message-function
        'langtool-autoshow-detail-popup)

  (defun my-lt-set-english ()
    (interactive)
    (setq langtool-default-language "en-US")
    (message "Language tool set to English")
    )

  (defun my-lt-set-russian ()
    (interactive)
    (setq langtool-default-language "ru-RU")
    (message "Language tool set to Russian")
    )

  :bind
    ("M-RET l t s" . langtool-check)
    ("M-RET l t d" . langtool-check-done)
    ("M-RET l t l" . langtool-switch-default-language)
    ("M-RET l t m" . langtool-show-message-at-point)
    ("M-RET l t c" . langtool-correct-buffer)
    ("M-RET l t e" . my-lt-set-english)
    ("M-RET l t r" . my-lt-set-russian)
    ("\C-x4s" . langtool-check)
    ("\C-x4q" . langtool-check-done)
    ("\C-x4l" . langtool-switch-default-language)
    ("\C-x44" . langtool-show-message-at-point)
    ("\C-x4c" . langtool-correct-buffer)
    ("\C-x4e" . my-lt-set-english)
    ("\C-x4r" . my-lt-set-russian)
    )

(use-package company
  :defer 1
  :diminish company-mode
  :config
  (use-package company-flx
    :config (company-flx-mode +1))
  (add-hook 'after-init-hook 'global-company-mode)

  (setq company-idle-delay 0.2)
  (setq company-tooltip-limit 20)
  (setq company-minimum-prefix-length 2)
  ;; invert the navigation direction if the the completion popup-isearch-match
  ;; is displayed on top (happens near the bottom of windows)
  ;(setq company-tooltip-flip-when-above t)
  (setq company-etags-ignore-case t)
  (setq company-show-quick-access t)
  (setq company-show-numbers t)
  (setq company-echo-delay 0)      ; remove annoying blinking
  (setq company-begin-commands '(self-insert-command)) ; start autocompletion only after typing
  (add-to-list 'company-backends 'company-jedi)
  (add-to-list 'company-backends 'company-racer)
  (setq company-dabbrev-downcase nil)
)

;; Elpy the Emacs Lisp Python Environment.
(use-package elpy
  :defer t
  :config
  (progn
    ;; Use ipython if available.
                                        ;(when (executable-find "ipython")
                                        ;  (elpy-use-ipython))
    ;; Don't use flymake if flycheck is available.
    ;; (when (require 'flycheck nil t)
    ;;   (setq elpy-modules
    ;;         (delq 'elpy-module-flymake elpy-modules))
    ;;   (add-hook 'elpy-mode-hook 'flycheck-mode))

    (setq elpy-modules '(elpy-module-sane-defaults
                         elpy-module-company
                         elpy-module-eldoc
                         elpy-module-highlight-indentation
                         elpy-module-pyvenv
                         elpy-module-flymake
                         elpy-module-autodoc
                         elpy-module-yasnippet
                         elpy-module-sane-defaults))
    (elpy-enable)
    (yas-reload-all)

    ;(delq 'elpy-module-flymake elpy-modules)
    (add-hook 'python-mode-hook
              (lambda ()
                (set (make-local-variable 'comment-inline-offset) 2)
                (auto-complete-mode -1)))

    ;; Don't use highlight-indentation-mode.
    (delete 'elpy-module-highlight-indentation elpy-modules)
    ;; this is messed with by emacs if you let it...
    (custom-set-variables
     '(elpy-rpc-backend "jedi")
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

  (add-hook 'python-mode-hook '(lambda ()
                                 (electric-indent-local-mode -1)
                                 ))

  :mode (("\\.py\\'" . elpy-mode))
  :bind (:map elpy-mode-map
              ("M-RET f c" . elpy-format-code)
              ("M-RET e n" . next-error)
              ("M-RET e p" . previous-error)
              ("M-RET b d" . python-add-breakpoint)
              ("M-RET b u" . python-add-pubreakpoint)
              )
  ;; pip install -U yapf==0.40.1
  )

(use-package py-autopep8
  :defer t
  :config
  (add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)
  )

(use-package nose
  :defer t
  :after elpy
  :commands (nosetests-one
             nosetests-pdb-one
             nosetests-all
             nosetests-pdb-all
             nosetests-module
             nosetests-pdb-module
             nosetests-suite
             nosetests-pdb-suite)
  :config
  (progn
    (add-to-list 'nose-project-root-files "setup.cfg")
    (setq nose-use-verbose nil))
  :bind
  (:map elpy-mode-map
        ("M-RET t a" . nosetests-all)
        ("<XF86Calculator>" . nosetests-all)
        )
  )

(use-package pyenv-mode
  :if (executable-find "pyenv")
  :defer t
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
;; (use-package ess-site
;;   :ensure ess)


;; Use a nice JavaScript mode.
;; (use-package js2-mode
;;   :disabled 1
;;   :mode
;;   (("\\.js\\'" . js2-mode)
;;   ))


(use-package tide
  :defer t)

(use-package rjsx-mode
  :defer t
  :mode ("\\.js\\'")
  :config
  (setq js2-basic-offset 2)
  (add-hook 'rjsx-mode-hook (lambda ()
                              ;; (flycheck-add-mode 'javascript-eslint 'rjsx-mode)
                              ; (my/use-eslint-from-mode-modules)
                              (flycheck-select-checker 'javascript-eslint)
                              ))
  ; (add-to-list 'auto-mode-alist '("\\.js\\'" . rjsx-mode))
  )

;; (use-package react-snippets
;;   :defer t)

(use-package emmet-mode
  :defer t
  :hook (web-mode rjsx-mode)
  :config
  (add-hook 'emmet-mode-hook (lambda ()
                               (setq emmet-indent-after-insert t))))

(use-package mode-local
  :defer t
  :config
  (setq-mode-local rjsx-mode emmet-expand-jsx-className? t)
  (setq-mode-local web-mode emmet-expand-jsx-className? nil))

(use-package lsp-mode
  :defer t
  :init
  (setq lsp-keymap-prefix "C-c l")
  :config
  (add-hook 'web-mode-hook #'lsp-deferred)
  (add-hook 'js-mode-hook #'lsp-deferred)
  (add-hook 'rjsx-mode-hook #'lsp-deferred)
;;  (add-hook 'prog-mode-hook #'lsp-deferred)
  :hook (
         (lsp-mode . lsp-enable-which-key-integration))
  :commands (lsp-deferred))
;; optionally
(use-package lsp-ui
  :commands lsp-ui-mode)
;; if you are helm user
(use-package helm-lsp
  :commands helm-lsp-workspace-symbol)
;; if you are ivy user
;; (use-package lsp-ivy :commands lsp-ivy-workspace-symbol)
(use-package lsp-treemacs
  :commands lsp-treemacs-errors-list)


(use-package lsp-haskell
  :config
  (add-hook 'haskell-mode-hook #'lsp-deferred)
  (add-hook 'haskell-literate-mode-hook #'lsp-deferred)
  :defer 1)

(use-package hindent
  :hook
  (add-hook 'haskell-mode-hook #'hindent-mode)
  :disabled t
  )

(use-package vue-mode
  :defer 1
  )
;; (use-package lsp-treemacs)
;; (use-package helm-lsp)
;; (use-package hydra)
;; (use-package helm-xref
;;   :config
;;   ; (define-key global-map [remap find-file] #'helm-find-files)
;;   ; (define-key global-map [remap execute-extended-command] #'helm-M-x)
;;   ; (define-key global-map [remap switch-to-buffer] #'helm-mini)
;;   )
;; (use-package dap-mode
;;   :defer 1
;;   :config
;;   (require 'dap-chrome)
;;   (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
;;   (yas-global-mode))

(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024)
      company-idle-delay 0.0
      company-minimum-prefix-length 1
      create-lockfiles nil) ;; lock files will kill `npm start'


(use-package prettier
  :defer t
  :config
  ;; (setq prettier-js-args '(
  ;;                          "--trailing-comma" "none"
  ;;                          "--bracket-spacing" "false"
  ;;                          ))
  :hook ((js2-mode . prettier-mode)
         (typescript-mode . prettier-mode)
         (rjsx-mode . prettier-mode)
         (css-mode . prettier-mode)
         (web-mode . prettier-mode))
  )

(use-package paredit
  :disabled t
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
  :defer t
  :disabled t
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

;; (use-package markdown-mode+
;;   :defer t
;;   :after markdown-mode
;;   )

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
  (add-to-list 'auto-mode-alist '("\\.tex\\'" . latex-mode))
  (add-to-list 'auto-mode-alist '("\\.sty\\'" . latex-mode))

  )

(use-package company-tabnine
  :ensure t
  :config
  (add-to-list 'company-backends #'company-tabnine)
  ;;; Run M-x company-tabnine-install-binary to install the TabNine binary for your system.
  )

(use-package company-auctex
  :config
  (company-auctex-init))

(use-package auctex-latexmk
  :defer t
  :after tex
  :config
  (auctex-latexmk-setup)
  (setq auctex-latexmk-inherit-TeX-PDF-mode t)
  )

(use-package slime
  :defer t
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
  (setq sli
        me-complete-symbol-function 'slime-fuzzy-complete-symbol
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
  :defer t
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
  (add-hook 'find-file-hook 'auto-insert)

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

(use-package add-node-modules-path )

(use-package web-mode
  :defer t
  :after company-web
  :config
  (require 'company-web-html)
  (require 'company-css)
  (add-hook 'html-mode-hook 'visual-line-mode)
  (add-hook 'web-mode-hook 'visual-line-mode)
  (add-hook 'js-mode-hook 'web-mode)
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
   ("\\.js\\'"         . web-mode)
   ; ("\\.jsx\\'"        . web-mode)
   ("\\.html\\'"       . web-mode)
   ("\\.htm\\'"        . web-mode)
   ("\\.djhtml\\'"     . web-mode)
   ("\\.pt\\'"         . web-mode)
   ))



;; Inpation mode

(use-package impatient-mode
  :defer t)

;;; CONTINUE:
;;; TODO: Other languages

;;(use-package color-theme)
(use-package color)
(use-package fiplr
  :config
  (setq fiplr-root-markers '(".git" ".svn"))
  (setq fiplr-ignored-globs '((directories (".git" ".svn"))
                              (files ("*.jpg" "*.png" "*.zip" "*~"))))
  (global-set-key (kbd "C-x f") 'fiplr-find-file))

(use-package w3m
  :if (executable-find "w3m")
  :defer t
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
                                        ; :disabled t
  :defer t
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

(use-package swiper
  ;; :disabled t
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  ;; (global-set-key "\C-s" 'swiper)
  (global-set-key (kbd "C-c C-r") 'ivy-resume)
  (global-set-key (kbd "<f6>") 'ivy-resume)
  ;; (global-set-key (kbd "M-x") 'counsel-M-x)
  ;; (global-set-key (kbd "C-x C-f") 'counsel-find-file)
  ;; (global-set-key (kbd "<f1> f") 'counsel-describe-function)
  ;; (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
  ;; (global-set-key (kbd "<f1> l") 'counsel-find-library)
  ;; (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
  ;; (global-set-key (kbd "<f2> u") 'counsel-unicode-char)
  ;; (global-set-key (kbd "C-c g") 'counsel-git)
  ;; (global-set-key (kbd "C-c j") 'counsel-git-grep)
  ;; (global-set-key (kbd "C-c k") 'counsel-ag)
  ;; (global-set-key (kbd "C-x l") 'counsel-locate)
  ;; (global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
  ;; (define-key read-expression-map (kbd "C-r") 'counsel-expression-history)
  )

(use-package ace-jump-mode
  :bind
  ("<print> a" . ace-jump-mode)
  )

(use-package avy
  :bind
  ("<print>" . avy-goto-char)
  ; ("<print> w" . avy-goto-word-1)
  ; ("<print> l" . avy-goto-line)
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
  :defer t
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
  (setq ispell-program-name "/usr/bin/hunspell")
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
  :bind ("C-M-<tab>" . flyspell-auto-correct-word)
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


;; ;; show the cursor when moving after big movements in the window
;; (use-package beacon
;;   :config
;;   (beacon-mode +1)
;;   )

;; show available keybindings after you start typing
(use-package which-key
  :config
  (which-key-mode +1)
  ;(which-key-setup-side-window-right)
  (which-key-setup-side-window-bottom)
  (setq which-key-idle-delay 0.1)
  )

; (use-package cask)

; (use-package mvn)

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
(global-hl-line-mode 1)

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
      compilation-scroll-output t ; Automatically scroll to first
      )

(defun kill-current-buffer ()
  (interactive)
  (kill-buffer (current-buffer)))

(global-set-key (kbd "C-x C-k") 'kill-current-buffer)
(global-set-key (kbd "C-x c") 'compile)
(global-set-key (kbd "C-x !") 'shell)

(defun my-compilation-mode-hook ()
  (setq truncate-lines nil) ;; automatically becomes buffer local
  (set (make-local-variable 'truncate-partial-width-windows) nil))
(add-hook 'compilation-mode-hook 'my-compilation-mode-hook)

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
  ;; (require 'helm-config)
  (helm-mode 1)
                                        ; (define-key global-map [remap find-file] 'helm-find-files)

  (define-key global-map [remap occur] 'helm-occur)
  (define-key global-map [remap list-buffers] 'helm-buffers-list)
  (define-key global-map [remap dabbrev-expand] 'helm-dabbrev)
  (global-set-key (kbd "M-x") 'helm-M-x)
                                        ;(global-set-key (kbd "C-x C-m") 'helm-M-x)
  (global-set-key (kbd "M-y") 'helm-show-kill-ring)
  (global-set-key (kbd "M-s o") 'helm-occur)
  (global-set-key (kbd "M-/") 'helm-dabbrev)
  (global-set-key (kbd "C-x b") 'helm-mini)
  (global-set-key (kbd "C-h a") 'helm-apropos)
  (global-set-key (kbd "C-x C-b") 'helm-buffers-list)
                                        ;(global-set-key (kbd "C-x C-f") 'helm-find-files)
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

  (custom-set-variables
   '(helm-completing-read-handlers-alist
     (quote
      ((describe-function . helm-completing-read-symbols)
       (describe-variable . helm-completing-read-symbols)
       (describe-symbol . helm-completing-read-symbols)
       (debug-on-entry . helm-completing-read-symbols)
       (find-function . helm-completing-read-symbols)
       (disassemble . helm-completing-read-symbols)
       (trace-function . helm-completing-read-symbols)
       (trace-function-foreground . helm-completing-read-symbols)
       (trace-function-background . helm-completing-read-symbols)
       (find-tag . helm-completing-read-default-find-tag)
       (org-capture . helm-org-completing-read-tags)
       (org-set-tags . helm-org-completing-read-tags)
       (ffap-alternate-file)
       (tmm-menubar)
       (find-file . ido)
       (find-file-at-point . ido)
       (ffap . helm-completing-read-sync-default-handler)
       (execute-extended-command)
       (dired-do-rename . helm-read-file-name-handler-1)
       (dired-do-copy . helm-read-file-name-handler-1)
       (dired-do-symlink . helm-read-file-name-handler-1)
       (dired-do-relsymlink . helm-read-file-name-handler-1)
       (dired-do-hardlink . helm-read-file-name-handler-1)
       (basic-save-buffer . helm-read-file-name-handler-1)
       (write-file . helm-read-file-name-handler-1)
       (write-region . helm-read-file-name-handler-1)
       (find-file-read-only . ido)))))
  )

(use-package helm-ls-git
  :config
  (global-set-key (kbd "C-<f7>") 'helm-ls-git-ls)
  )

(use-package helm-ispell)
;(use-package helm-git)
(use-package helm-ag
  :defer t)
(use-package helm-company
  :defer t
  :config
  (define-key company-mode-map (kbd "C-:") 'helm-company)
  (define-key company-active-map (kbd "C-:") 'helm-company)
  )
(use-package helm-pydoc
  :defer t
  :config
  (define-key python-mode-map (kbd "C-c C-d") 'helm-pydoc))

(use-package helm-swoop
  :config
  (global-set-key (kbd "M-i") 'helm-swoop)
  (global-set-key (kbd "M-I") 'helm-swoop-back-to-last-point)
  (global-set-key (kbd "C-c M-i") 'helm-multi-swoop)
  (global-set-key (kbd "C-x M-i") 'helm-multi-swoop-all)
  )

(use-package helm-themes)

;; (use-package cursor-chg
;;   :config
;;   (setq curchg-default-cursor-color "LightSkyBlue1")
;;   (setq curchg-input-method-cursor-color "red")
;;   (setq curchg-default-cursor-type '(hbar . 7))
;;   (change-cursor-mode 1) ; On for overwrite/read-only/input mode
;;   (toggle-cursor-type-when-idle 1) ; On when idle
;;   )

(use-package helm-tramp
  :config
  (setq tramp-default-method "ssh")
  (define-key global-map  (kbd "M-RET h t")  'helm-tramp)
  )

(use-package jedi-direx
  :defer t)

(use-package company-jedi
  :defer t
  :config
  (add-to-list 'company-backends 'company-jedi)
  )

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

(use-package forth-mode
  :defer t)

(use-package vala-mode
  :defer t)
(use-package vala-snippets
  :defer t)

(use-package org
  :defer t)
(use-package orgnav
  :defer t)
(use-package org-bullets
  :defer t
  :config
  (add-hook 'org-mode-hook 'org-bullets-mode)
  (setq org-bullets-bullet-list '("○" "☉" "◎" "◉" "○" "◌" "◎" "●" "◦" "◯" "⚪" "⚫" "⚬" "❍" "￮" "⊙" "⊚" "⊛" "∙" "∘"))
  ;; (setq org-ellipsis '("↝" "⇉" "⇝" "⇢" "⇨" "⇰" "➔" "➙" "➛" "➜" "➝" "➞"))
  )
; (use-package ox-pandoc)
(use-package ox-twbs
  :defer t)
(use-package ansi-color
  :config
  (defun my/ansi-colorize-buffer ()
    (let ((buffer-read-only nil))
      (ansi-color-apply-on-region (point-min) (point-max))))
  (add-hook 'compilation-filter-hook 'my/ansi-colorize-buffer)
  )

(use-package d-mode
  :defer t)

;; (use-package dante
;;   :ensure t
;;   :after haskell-mode
;;   :commands 'dante-mode
;;   :init
;;   (add-hook 'haskell-mode-hook 'flycheck-mode)
;;   ;; OR for flymake support:
;;   (add-hook 'haskell-mode-hook 'flymake-mode)
;;   (remove-hook 'flymake-diagnostic-functions 'flymake-proc-legacy-flymake)

;;   (add-hook 'haskell-mode-hook 'dante-mode)
;;   :bind (:map haskell-mode-map
;;               ("M-RET h e" . dante-eval-block)
;;               ;; ("M-RET e n" . next-error)
;;               ;; ("M-RET e p" . previous-error)
;;               ;; ("M-RET b d" . python-add-breakpoint)
;;               ;; ("M-RET b u" . python-add-pubreakpoint)
;;               )
;;   :config
;;   (flycheck-add-next-checker 'haskell-dante '(info . haskell-hlint))
;;   )

(use-package haskell-mode
  :defer 1
  )


;; lualatex preview
(setq org-latex-pdf-process
  '("lualatex -shell-escape -interaction nonstopmode %f"
    "lualatex -shell-escape -interaction nonstopmode %f"))

(setq luamagick '(luamagick :programs ("lualatex" "convert")
       :description "pdf > png"
       :message "you need to install lualatex and imagemagick."
       :use-xcolor t
       :image-input-type "pdf"
       :image-output-type "png"
       :image-size-adjust (1.0 . 1.0)
       :latex-compiler ("lualatex -interaction nonstopmode -output-directory %o %f")
       :image-converter ("convert -density %D -trim -antialias %f -quality 100 %O")))

;(add-to-list 'org-preview-latex-process-alist luamagick)

;(setq org-preview-latex-default-process 'luamagick)



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

(autoload 'logtalk-mode "logtalk" "Major mode for editing Logtalk programs." t)
(add-to-list 'auto-mode-alist '("\\.lgt\\'" . logtalk-mode))
(add-to-list 'auto-mode-alist '("\\.logtalk\\'" . logtalk-mode))
;(add-to-list 'auto-mode-alist '("\\.lgt\\'" . prolog-mode))
;(add-to-list 'auto-mode-alist '("\\.logtalk\\'" . prolog-mode))
(add-hook 'logtalk-mode-hook (lambda ()
                               (yas-minor-mode-on)
                               ))

(defun compile-test ()
  (interactive)
  (comile "make -k tests")
  )

(add-hook 'prolog-mode-hook (lambda ()
                              (local-set-key (kbd "M-RET t a") 'compile-test)
                            )
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
  (replace-regexp "\\(\\w+\\)[-­]\\s-+\\(\\w+\\)" "\\1\\2" nil (line-beginning-position) (line-end-position))
  (replace-regexp "\\(\\w+\\)­\\(\\w+\\)" "\\1-\\2" nil (line-beginning-position) (line-end-position))
  (replace-regexp "\\s-*вЂ\”" "~--" nil (line-beginning-position) (line-end-position))
  (replace-regexp "\\s—" "~--" nil (line-beginning-position) (line-end-position))
  (replace-regexp "\\(\\w+\\)-\\(\\w+\\)" "\\1\"=\\2" nil (line-beginning-position) (line-end-position))
  (replace-regexp "\\.\\.\\." "\\\\ldots{}" nil (line-beginning-position) (line-end-position))
  (replace-regexp "\\[\\([[:digit:]]+\\)\\]" "\\\\cite{b\\1}" nil (line-beginning-position) (line-end-position))
  ;; (replace-regexp "\\(\\w\\|\\.\\):" "\\1\\\\,:" nil (line-beginning-position) (line-end-position))
  (replace-regexp "\\([тТ]\\.\\)\\s-*\\(\\w\\.\\)" "\\1~\\2" nil (line-beginning-position) (line-end-position))
  (replace-regexp "\\([[:upper:]]\\.\\)\\s-*\\([[:upper:]]\\.\\)\\s-+\\([[:upper:]]\\w*\\)" "\\1~\\2~\\3" nil (line-beginning-position) (line-end-position))
  (replace-regexp "\\([[:upper:]]\\.\\)\\s-+\\([[:upper:]]\\w*\\)" "\\1~\\2" nil (line-beginning-position) (line-end-position))
  (replace-regexp "\"\\(\\w+\\)" "<<\1" nil (line-beginning-position) (line-end-position))
  (replace-regexp "\\(\\w+\\)\"" "\1>>" nil (line-beginning-position) (line-end-position))
  (replace-regexp "\"\\(\\.\\)\"" "<<\1>>" nil (line-beginning-position) (line-end-position))
  ;(replace-regexp "\\s-+" "_")
  )

(defun reconstruct-paragraph-simple ()
  "Takes a multi-line paragraph and makes it into a single line of text."
  (interactive)
  (let ((fill-column (point-max)))
    (fill-paragraph nil)
    )
  ;(replace-regexp "\\(\\w+\\)[-­]\\s-+\\(\\w+\\)" "\\1\\2" nil (line-beginning-position) (line-end-position))
  ;(replace-regexp "\\(\\w+\\)­\\(\\w+\\)" "\\1-\\2" nil (line-beginning-position) (line-end-position))
  (replace-regexp "\\s-*вЂ\”" "~--" nil (line-beginning-position) (line-end-position))
  ;(replace-regexp "\\s—" "~--" nil (line-beginning-position) (line-end-position))
  ;(replace-regexp "\\(\\w+\\)-\\(\\w+\\)" "\\1\"=\\2" nil (line-beginning-position) (line-end-position))
  ;(replace-regexp "\\.\\.\\." "\\\\ldots{}" nil (line-beginning-position) (line-end-position))
  ;(replace-regexp "\\[\\([[:digit:]]+\\)\\]" "\\\\cite{b\\1}" nil (line-beginning-position) (line-end-position))
  ;; (replace-regexp "\\(\\w\\|\\.\\):" "\\1\\\\,:" nil (line-beginning-position) (line-end-position))
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
(define-key global-map [f9] 'reconstruct-paragraph-simple)
(define-key global-map [C-f9] 'reconstruct-paragraph)
(define-key global-map [f12] 'reconstruct-minted-line)
(define-key global-map [f8] 'delete-other-windows)
(define-key global-map [C-f8] 'delete-window)

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
          :family "Fira code"
          ;:height 160 ;Seseg
          ;:height 80
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
(global-set-key (kbd "M-RET c c") 'compile)
(global-set-key (kbd "M-RET c r") 'recompile)
(global-set-key (kbd "<XF86Calculator>") 'recompile)
(global-set-key (kbd "M-RET m w") 'web-mode)

(defun my-add-tilde ()
  (interactive)
  (delete-char 1)
  (insert "~"))
(global-set-key (kbd "<f6>") 'my-add-tilde)


(add-hook 'prolog-mode-hook
          '(lambda ()
             (local-set-key (kbd "<XF86Calculator>") #'recompile)
             )
          ; prolog-mode-map unset M-Ret key, make it Ctrl-Ret
          )

(defun cfg:reverse-input-method (input-method)
  "Build the reverse mapping of single letters from INPUT-METHOD."
  (interactive
   (list (read-input-method-name "Use input method (default current): ")))
  (if (and input-method (symbolp input-method))
      (setq input-method (symbol-name input-method)))
  (let ((current current-input-method)
        (modifiers '(nil (control) (meta) (control meta))))
    (when input-method
      (activate-input-method input-method))
    (when (and current-input-method quail-keyboard-layout)
      (dolist (map (cdr (quail-map)))
        (let* ((to (car map))
               (from (quail-get-translation
                      (cadr map) (char-to-string to) 1)))
          (when (and (characterp from) (characterp to))
            (dolist (mod modifiers)
              (define-key local-function-key-map
                (vector (append mod (list from)))
                (vector (append mod (list to)))))))))
    (when input-method
      (activate-input-method current))))

(cfg:reverse-input-method 'russian-computer)

(defun my-package-recompile()
  "Recompile all packages"
  (interactive)
  (byte-recompile-directory "~/.emacs.d/elpa" 0 t))

(require 'cursor-chg)
(setq curchg-default-cursor-color "LightSkyBlue1")
(setq curchg-input-method-cursor-color "red")
(setq curchg-default-cursor-type '(hbar . 7))
(change-cursor-mode 1) ; On for overwrite/read-only/input mode
(toggle-cursor-type-when-idle 1) ; On when idle


(put 'narrow-to-page 'disabled nil)

(add-hook 'logtalk-mode-hook (lambda () (setq indent-tabs-mode nil)))

;;(switch-to-buffer "*Compile-Log*")
;;(delete-window)
;;(switch-to-buffer "*scratch*")

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1))


(setq company-tooltip-align-annotations t)

;; formats the buffer before saving
;; (add-hook 'before-save-hook 'tide-format-before-save)
;; (add-hook 'js2-mode-hook #'setup-tide-mode)
;; (add-hook 'typescript-mode-hook #'setup-tide-mode)
;; (add-hook 'rjsx-mode-hook #'setup-tide-mode)

(add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
(add-hook 'web-mode-hook
          (lambda ()
            (when (string-equal "tsx" (file-name-extension buffer-file-name))
              ; (setup-tide-mode)
              (prettier-mode)
              )
            )
          )

(eval-after-load 'web-mode
  '(progn
       (add-hook 'web-mode-hook #'add-node-modules-path)
       (add-hook 'web-mode-hook #'prettier-mode)
       ;; (flycheck-add-mode 'typescript-tslint 'web-mode)
       ))
;; Work with git with magic ease.
(use-package magit
  :defer t
  :if (executable-find "git")
  :bind
  (("C-x g" . magit-status)
   ("M-RET m s" . magit-status))
  ;:commands
  ;(magit-status)
  :config
  (setq magit-push-always-verify nil)
  (set-default 'magit-unstage-all-confirm t)
  (set-default 'magit-stage-all-confirm t)
  (set-default 'magit-revert-buffers 'silent)
  (global-set-key "\C-x\ \C-m" 'magit-status))
;; Don't use tabs, magit!
;; (use-package magit-filenotify
;;   :commands
;;   (magit-after-save-refresh-status
;;    magit-filenotify-mode)
;;   :config
;;   (add-hook 'after-save-hook 'magit-after-save-refresh-status)
;;   (add-hook 'magit-status-mode-hook 'magit-filenotify-mode))

(use-package magithub
  :disabled 1
  :defer t
  :after magit)

; (require 'magit-process nil t)

;; (use-package grammarly
;;   :config
;;   (require 'gram-creds)
;;   )

;; (use-package flycheck-grammarly)

;;(require 'tramp)
;;(setq tramp-default-method "scp")

(use-package oberon
  :defer 1
  :mode (("\\.oberon\\'" . oberon-mode))
  :config
  (add-hook 'oberon-mode-hook (lambda () (abbrev-mode t)))
  )

(use-package julia-mode
  :defer 1
  )

(use-package clips-mode
  :defer 1
  :config
  (setq inferior-clips-program "clips")
  )

(use-package go-tranlate
  :defer 1
  :disabled 1
  :config
  (setq gts-translate-list '(("en" "zh")))
  (setq gts-default-translator
        (gts-translator
         :picker (gts-prompt-picker)
         :engines (list (gts-google-engine) (gts-google-rpc-engine))
         :render (gts-buffer-render)))
  )

(use-package guess-language
  :defer 1
  :config
  (setq guess-language-languages '(en ru de))
  (setq guess-language-min-paragraph-length 35)
  (add-hook 'text-mode-hook (lambda () (guess-language-mode 1)))
  )

(use-package txl
  :defer 1
  :config
  (setq txl-languages '(EN-US . RU))
  (setq txl-deepl-api-key "my-api-key")
  (setq txl-deepl-api-url "https://api-free.deepl.com/v2/translate")
  :bind
  (
   ("M-RET t d" . txl-translate-region-or-paragraph))
  )

(use-package babel
  :defer 1
  :config
  (setq babel-preferred-from-language "English")
  (setq babel-preferred-to-language "Russian")
  (defun babel-libretranslate-fetch (msg from to)
    "Connect to localhost and request the translation."
    (unless (babel-libretranslate-translation from to)
      (error "Libretranslate can't translate from %s to %s" from to))
    (let* ((pairs `(("source" . ,from)
                    ("target" . ,to)
                    ("q" . ,msg)
                    ("sentencesplit" . "false")
                    ("api_key" . "")))
           (url-request-extra-headers
            '(("Content-Type" . "application/x-www-form-urlencoded")
              ("Origin" . "https://lt.iscnet.ru")))
           (request-url "https://lt.iscnet.ru/translate")
           (url-request-method "POST")
           (url-request-data (babel-form-encode pairs)))
      (babel-url-retrieve request-url)))

  (defun babel-libretranslate-wash ()
    "Parse JSON response of Libretranslate.com."
    (goto-char (point-min))
    (let* ((json-object-type 'alist)
           (json-response (json-read))
           (translation (json-get json-response '(translatedText)))
           (error-message (json-get json-response '(error))))
      (erase-buffer)
      (when error-message
        (error "Api error: %s" error-message))
      (insert translation)))

  (defun babel-line ()
    "Use a web translation service to translate the current line.
   Yank the translation to the kill-ring."
    (interactive)
    (kill-new (babel-as-string-default (thing-at-point 'line t))))

  (defun babel-selection ()
    "Use a web translation service to translate the current line.
   Yank the translation to the kill-ring."
    (interactive)
    (let
        (
         (trans (babel-as-string-default (buffer-substring-no-properties (mark) (point))))
         )
      (kill-new trans)
      (kill-region (mark) (point))
      (insert trans)))

  (defun babel-libretranslate-translation (from to)
    (and
     (assoc from babel-libretranslate-languages)
     (assoc to babel-libretranslate-languages))

    :bind
    (
     ("M-RET t b" . babel-region))))

(define-key global-map [f7] 'babel-line)
(define-key global-map [S-f7] 'babel-selection)


(use-package sparql-mode
  :defer 1
  :config
  (add-to-list 'auto-mode-alist '("\\.sparql$" . sparql-mode))
  (add-to-list 'auto-mode-alist '("\\.rq$" . sparql-mode))
  (add-hook 'sparql-mode-hook 'global-company-mode)
  )

(use-package yaml-mode
  :defer 1
  :config
    (add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
    (add-hook 'yaml-mode-hook
      '(lambda ()
        (define-key yaml-mode-map "\C-m" 'newline-and-indent)))
  )

(provide 'init)
;;; init.el ends here
