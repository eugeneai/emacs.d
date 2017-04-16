(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-PDF-mode t)
 '(TeX-auto-save t)
 '(TeX-command-extra-options "-shell-escape")
 '(TeX-master nil)
 '(TeX-parse-self t)
 '(TeX-save-query nil)
 '(TeX-source-correlate-method (quote synctex))
 '(TeX-source-correlate-mode t)
 '(TeX-source-correlate-start-server (quote ask))
 '(ac-ispell-fuzzy-limit 2)
 '(ac-ispell-requires 3)
 '(blink-cursor-mode nil)
 '(bookmark-default-file "/home/eugeneai/.emacs.d/bookmarks.bmk")
 '(column-number-mode t)
 '(company-eclim-executable "/usr/lib/eclipse/eclim")
 '(custom-enabled-themes (quote (eugeneai-theme)))
 '(custom-safe-themes
   (quote
    ("f02f72b55f2d442a22bb9ca83ab8bf3d92be0c9ddbeb82d37af9b8b780fa2c82" "d889788e1951cb2b72d899ee153798f9b3a7b2a8749b42d07fd21d4dc950912d" "7f854fb4d0f4c942cfb0f9831352ba39febf0676a97968b06d08034866892487" "96efa418b6d6c56e1c78f984ce1e4da286913a938ea9f8de0d1898d2bf28ba1a" "59bc4036be77cba46e994cb759c1ac782535314a7ffcc187486dc8623407606f" "9b9744b1728784db01c6f406c38e364944a81b4b355eded96a358a2bc95cb775" "4cf3221feff536e2b3385209e9b9dc4c2e0818a69a1cdb4b522756bcdf4e00a4" "4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" "024b0033a950d6a40bbbf2b1604075e6c457d40de0b52debe3ae994f88c09a4a" "5ea08b040c5515152d2bcae79a05ae5c98339b5729c359d02437bf4cc567cca5" "e200f481e31ceee929079ad8a6f629e45bdad45e5ac27101c89d55f4827071db" "e885ba299f1f0f0927bc8b10136a704c1ec05c7d04b7011559439dd9e56c56ab" "6252dbc43eefee0edc82ef000659ece4f77c4c989b4571d8d23485efc5e9ef4d" "d5af8f6ee92912a7bac8185ed447e1e825252728a1ebd1d41eb2da660d27ad62" default)))
 '(default-input-method "russian-computer")
 '(eclim-auto-save nil)
 '(eclim-executable "/usr/lib/eclipse/eclim")
 '(eclimd-autostart t)
 '(eclimd-autostart-with-default-workspace t)
 '(eclimd-default-workspace "~/.local/eclipse")
 '(elpy-rpc-backend "jedi")
 '(epy-load-yasnippet-p t)
 '(help-at-pt-display-when-idle (quote (flymake-overlay)) nil (help-at-pt))
 '(help-at-pt-timer-delay 1.9)
 '(httpd-port 8380)
 '(ispell-dictionary "english")
 '(jdee-complete-function (quote jdee-complete-menu))
 '(jdee-global-classpath
   (quote
    ("/home/eugeneai/Development/codes/cells-group/cells-ssdc/target/classes" "~/.m2/repository")))
 '(jdee-jdk (quote ("1.8")))
 '(jdee-jdk-registry
   (quote
    (("1.8" . "/usr/lib/jvm/java-8-openjdk")
     ("1.8-64" . "/usr/lib64/jvm/java-8-openjdk"))))
 '(jdee-server-dir "~/.local/jdee-server")
 '(js-indent-level 2)
 '(load-prefer-newer t)
 '(magit-auto-revert-mode t)
 '(markdown-coding-system (quote utf-8))
 '(markdown-command-needs-filename t)
 '(markdown-xhtml-header-content "<meta charset=\"utf-8\">")
 '(minibuffer-auto-raise t)
 '(minibuffer-frame-alist (quote ((width . 80) (height . 1))))
 '(package-selected-packages
   (quote
    (avy flycheck impatient-mode w3m fiplr color-theme auctex-latexmk auctex ac-ispell goto-last-change markdown-mode+ markdown-mode rainbow-delimiters rainbow-mode js2-mode ess py-autopep8 elpy zoom-frm multiple-cursors page-break-lines browse-kill-ring projectile smex flx-ido ido-vertical-mode magit-filenotify magit whole-line-or-region expand-region drag-stuff smartparens ag better-defaults mvn company-emacs-eclim switch-window switch-windows sr-speedbar package-build shut-up epl git commander f dash s cask ttl-mode vala-mode geiser company-web company-css company-web-html web-mode pandoc-mode pandoc slime comany which-key beacon smart-mode-line anzu htmlize ace-jump-mode pyenv-mode-auto pyenv-mode nose spacemacs-theme abbrev abbrev-mode cursor-chg helm-themes helm-pydoc helm-company helm-ag helm-ispell helm-ls-git helm use-package)))
 '(prolog-program-name
   (quote
    (((getenv "EPROLOG")
      (eval
       (getenv "EPROLOG")))
     (eclipse "eclipse")
     (mercury nil)
     (sicstus "sicstus")
     (swi "pl")
     (gnu "gprolog")
     (t "prolog"))))
 '(python-shell-completion-native-disabled-interpreters (quote ("python" "pypy")))
 '(python-shell-interpreter "python3")
 '(rw-hunspell-default-dictionary "russian")
 '(rw-hunspell-dicpath-list (quote ("/usr/share/hunspell")))
 '(rw-hunspell-make-dictionary-menu t)
 '(rw-hunspell-use-rw-ispell t)
 '(safe-local-variable-values
   (quote
    ((TeX-command-extra-options . "-shell-escape")
     (TeX-auto-save . t)
     (TeX-parse-self . t)
     (major-mode . rst-mode)
     (eval ispell-change-dictionary "ru_RU_hunspell")
     (eval ispell-change-dictionary "russian")
     (TeX-source-correlate-start-server)
     (TeX-source-correlate-mode . 1)
     (TeX-PDF-mode . 1)
     (eval ispell-change-dictionary "ru-yeyo")
     (ispell-local-dictionary quote ru-yeyo)
     (ispell-local-dictionary . ru-yeyo)
     (ispell-dictionary . ru-yeyo)
     (TeX-master . t)
     (ispell-dictionary . american)
     (py-indent-offset . 4)
     (TeX-master . "dis")
     (py-master-file . "/path/to/interactivetest.py")
     (whitespace-line-column . 80)
     (lexical-binding . t))))
 '(show-paren-mode t)
 '(tab-width 4)
 '(text-mode-hook (quote (turn-on-flyspell text-mode-hook-identify)))
 '(tool-bar-mode nil)
 '(w3-honor-stylesheets t)
 '(which-function-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Fira Mono" :foundry "CTDB" :slant normal :weight normal :height 113 :width normal))))
 '(font-latex-verbatim-face ((t (:inherit Fira Sans Mono :foreground "burlywood"))))
 '(magit-branch-current ((t (:inherit magit-branch-local :background "dark magenta"))))
 '(magit-branch-local ((t (:foreground "gold2"))))
 '(show-paren-match ((t (:background "gray30" :foreground "white"))))
 '(tex-verbatim ((t (:family "Inconsolata LGC Medium")))))
