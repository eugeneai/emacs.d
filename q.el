;;; Configuration --- Summary
;;; Commentary:
;; This is configuration for Emacs.
;;; Code:
;; init.el --- Emacs configuration

;; alias qe='emacs -nw -q --load ~/.emacs.d/q.el'
;; in /etc/environment
;; in /etc/profile
;; export EDITOR="emacs -nw -q --load ~/.emacs.d/q.el"
;;
;; git config --global core.editor 'emacs -nw -q --load ~/.emacs.d/q.el'

;; Consider using abbreviations.
(add-hook 'text-mode-hook (lambda () (abbrev-mode 1)))
(setq abbrev-file-name             ;; tell emacs where to read abbrev
      "~/.emacs.d/private/abbrev_defs")    ;; definitions from...
(setq save-abbrevs t)              ;; save abbrevs when files are saved
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
(use-package ag
  :defer t
  )

;; expand-region is that new hotness.
(use-package expand-region
  :bind ("M-p" . er/expand-region))


;; FIXME: Cannot load it
(use-package spacemacs-theme
  :disabled t
  :config
  (load-theme 'spacemacs-dark t)
  )


;; Get useful line behaviors when region is not active.
(use-package whole-line-or-region
  :config (whole-line-or-region-mode t)
  :diminish whole-line-or-region-mode)


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

(use-package goto-last-change
  :config
  (global-set-key (kbd "C-x C-\\") 'goto-last-change)
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

;; highlight the current line
(global-hl-line-mode +1)

;; tramp, for sudo access
(require 'tramp)
;; keep in mind known issues with zsh - see emacs wiki
(setq tramp-default-method "ssh")

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


;; Do not blink
(blink-cursor-mode -1)

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

(global-set-key (kbd "C-c q") 'auto-fill-mode)


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
(define-key global-map [f4] 'delete-other-windows)

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

(add-hook 'before-save-hook 'delete-trailing-whitespace)

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


;(load custom-file)

(defun set-input-method-english ()
  (interactive)
  (if current-input-method (toggle-input-method))
  )

;; That's need to be here
(require 'open-next-line)
(global-set-key (kbd "C-j") 'newline-and-indent)
(global-set-key (kbd "RET") 'newline-and-indent)
(defalias 'qrr 'query-replace-regexp)

(provide 'q)
;;; init.el ends here
