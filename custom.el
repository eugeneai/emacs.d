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
 '(TeX-source-correlate-method 'synctex)
 '(TeX-source-correlate-mode t)
 '(TeX-source-correlate-start-server 'ask)
 '(ac-ispell-fuzzy-limit 2)
 '(ac-ispell-requires 3)
 '(babel-select-output-window nil)
 '(blink-cursor-mode nil)
 '(bookmark-default-file "/home/eugeneai/.emacs.d/bookmarks.bmk")
 '(column-number-mode t)
 '(company-backends
   '(company-jedi
     (company-auctex-macros company-auctex-symbols
                            company-auctex-environments)
     company-auctex-bibs company-auctex-labels company-bbdb
     company-eclim company-semantic company-clang company-xcode
     company-cmake company-capf company-files
     (company-dabbrev-code company-gtags company-etags
                           company-keywords)
     company-oddmuse company-dabbrev))
 '(company-eclim-executable "/usr/lib/eclipse/eclim")
 '(custom-safe-themes
   '("fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088"
     "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476"
     "f02f72b55f2d442a22bb9ca83ab8bf3d92be0c9ddbeb82d37af9b8b780fa2c82"
     "d889788e1951cb2b72d899ee153798f9b3a7b2a8749b42d07fd21d4dc950912d"
     "7f854fb4d0f4c942cfb0f9831352ba39febf0676a97968b06d08034866892487"
     "96efa418b6d6c56e1c78f984ce1e4da286913a938ea9f8de0d1898d2bf28ba1a"
     "59bc4036be77cba46e994cb759c1ac782535314a7ffcc187486dc8623407606f"
     "9b9744b1728784db01c6f406c38e364944a81b4b355eded96a358a2bc95cb775"
     "4cf3221feff536e2b3385209e9b9dc4c2e0818a69a1cdb4b522756bcdf4e00a4"
     "4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328"
     "024b0033a950d6a40bbbf2b1604075e6c457d40de0b52debe3ae994f88c09a4a"
     "5ea08b040c5515152d2bcae79a05ae5c98339b5729c359d02437bf4cc567cca5"
     "e200f481e31ceee929079ad8a6f629e45bdad45e5ac27101c89d55f4827071db"
     "e885ba299f1f0f0927bc8b10136a704c1ec05c7d04b7011559439dd9e56c56ab"
     "6252dbc43eefee0edc82ef000659ece4f77c4c989b4571d8d23485efc5e9ef4d"
     "d5af8f6ee92912a7bac8185ed447e1e825252728a1ebd1d41eb2da660d27ad62"
     default))
 '(default-input-method "russian-computer")
 '(eclim-auto-save nil)
 '(eclim-executable "/usr/lib/eclipse/eclim")
 '(eclimd-autostart t)
 '(eclimd-autostart-with-default-workspace t)
 '(eclimd-default-workspace "~/.local/eclipse")
 '(elpy-rpc-backend "jedi")
 '(helm-completing-read-handlers-alist
   '((describe-function . helm-completing-read-symbols)
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
     (ffap-alternate-file) (tmm-menubar) (find-file . ido)
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
     (find-file-read-only . ido)))
 '(helm-completion-style 'helm)
 '(help-at-pt-display-when-idle '(flymake-overlay) nil (help-at-pt))
 '(help-at-pt-timer-delay 1.9)
 '(httpd-port 8380)
 '(ido-enable-flex-matching t)
 '(ispell-dictionary "english")
 '(jdee-complete-function 'jdee-complete-menu)
 '(jdee-global-classpath
   '("/home/eugeneai/Development/codes/cells-group/cells-ssdc/target/classes"
     "~/.m2/repository"))
 '(jdee-jdk '("1.8"))
 '(jdee-jdk-registry
   '(("1.8" . "/usr/lib/jvm/java-8-openjdk")
     ("1.8-64" . "/usr/lib64/jvm/java-8-openjdk")))
 '(jdee-server-dir "~/.local/jdee-server")
 '(js-indent-level 2)
 '(load-prefer-newer t)
 '(lsp-haskell-server-path
   "/home/eugeneai/.ghcup/bin/haskell-language-server-9.6.1~1.10.0.0")
 '(magit-auto-revert-mode t)
 '(markdown-coding-system 'utf-8)
 '(markdown-command-needs-filename t)
 '(markdown-xhtml-header-content "<meta charset=\"utf-8\">")
 '(minibuffer-auto-raise t)
 '(minibuffer-frame-alist '((width . 80) (height . 1)))
 '(mouse-wheel-scroll-amount '(1 ((shift) . 5) ((control) . 0.5)))
 '(package-selected-packages
   '(ac-ispell ace-jump-mode add-node-modules-path ag anzu auctex-latexmk
               babel better-defaults browse-kill-ring clips-mode
               company-auctex company-flx company-jedi company-tabnine
               company-web d-mode default-text-scale diminish
               drag-stuff elpy emmet-mode expand-region fiplr flx-ido
               forth-mode geiser goto-last-change haskell-mode helm-ag
               helm-company helm-ispell helm-ls-git helm-lsp
               helm-pydoc helm-swoop helm-themes helm-tramp
               highlight-parentheses ido-vertical-mode impatient-mode
               jedi-direx julia-mode langtool lsp-haskell lsp-treemacs
               lsp-ui magit multiple-cursors nose oberon org-bullets
               orgnav ox-twbs page-break-lines pandoc-mode prettier
               projectile py-autopep8 pyenv-mode rjsx-mode slime
               smart-mode-line smex sparql-mode sr-speedbar swiper
               switch-window tide transient ttl-mode txl vala-mode
               vala-snippets vue-mode w3m web-mode
               whole-line-or-region yaml-mode yasnippet-snippets))
 '(prolog-program-name
   '(((getenv "EPROLOG") (eval (getenv "EPROLOG"))) (eclipse "eclipse")
     (mercury nil) (sicstus "sicstus") (swi "swipl") (gnu "gprolog")
     (t "prolog")))
 '(prolog-system 'swi t)
 '(python-shell-completion-native-disabled-interpreters '("python" "pypy"))
 '(python-shell-interpreter "python3")
 '(rw-hunspell-default-dictionary "russian")
 '(rw-hunspell-dicpath-list '("/usr/share/hunspell"))
 '(rw-hunspell-make-dictionary-menu t)
 '(rw-hunspell-use-rw-ispell t)
 '(safe-local-variable-values
   '((haskell-process-use-ghci . t) (haskell-indent-spaces . 4)
     (test-case-name . pymeta.test.test_runtime)
     (TeX-engine . lualatex)
     (TeX-command-extra-options . "-shell-escape") (TeX-auto-save . t)
     (TeX-parse-self . t) (major-mode . rst-mode)
     (eval ispell-change-dictionary "ru_RU_hunspell")
     (eval ispell-change-dictionary "russian")
     (TeX-source-correlate-start-server)
     (TeX-source-correlate-mode . 1) (TeX-PDF-mode . 1)
     (eval ispell-change-dictionary "ru-yeyo")
     (ispell-local-dictionary quote ru-yeyo)
     (ispell-local-dictionary . ru-yeyo) (ispell-dictionary . ru-yeyo)
     (TeX-master . t) (ispell-dictionary . american)
     (py-indent-offset . 4) (TeX-master . "dis")
     (py-master-file . "/path/to/interactivetest.py")
     (whitespace-line-column . 80) (lexical-binding . t)))
 '(show-paren-mode t)
 '(tab-width 4)
 '(text-mode-hook '(turn-on-flyspell text-mode-hook-identify))
 '(tool-bar-mode nil)
 '(w3-honor-stylesheets t)
 '(warning-suppress-types '((comp)))
 '(which-function-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Source Code Pro" :slant normal :weight semi-bold :height 177 :width normal :foundry "ADBO"))))
 '(company-preview ((t (:inherit default :background "medium blue" :foreground "darkgray"))))
 '(company-scrollbar-bg ((t (:background "#4ccc4ccc4ccc"))) t)
 '(company-scrollbar-fg ((t (:background "#3fff3fff3fff"))) t)
 '(company-tooltip ((t (:inherit default :background "gray30" :foreground "white"))))
 '(company-tooltip-common ((t (:inherit font-lock-constant-face :background "goldenrod" :foreground "black"))))
 '(company-tooltip-selection ((t (:inherit font-lock-function-name-face))))
 '(font-latex-verbatim-face ((t (:family "Fira Code" :foreground "burlywood"))))
 '(line-number ((t (:background "gray10" :foreground "gold" :slant normal :weight bold :height 1.1 :family "Ubuntu Mono"))))
 '(line-number-current-line ((t (:inherit line-number :background "forest green" :foreground "white"))))
 '(logtalk-default-face ((t (:inherit nil :stipple nil :background "gray20" :foreground "wheat1" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :width normal :foundry "CTDB" :family "Fira Code"))) t)
 '(magit-branch-current ((t (:inherit magit-branch-local :background "dark magenta"))))
 '(magit-branch-local ((t (:background "turquoise4" :foreground "gold2"))))
 '(magit-branch-remote ((t (:background "saddle brown" :foreground "DarkSeaGreen2"))))
 '(minibuffer-prompt ((t (:foreground "CadetBlue1"))))
 '(mode-line ((t (:background "black" :foreground "gray60" :inverse-video nil :weight normal :height 0.65 :family "Fira Code"))))
 '(mode-line-inactive ((t (:background "#404045" :foreground "gray60" :inverse-video nil :height 0.6))))
 '(show-paren-match ((t (:inherit default :background "gray50" :foreground "gray100" :underline nil))))
 '(show-paren-mismatch ((t (:inherit default :foreground "#e0211d" :underline nil :bold nil))))
 '(tex-verbatim ((t (:family "Fira Code")))))
