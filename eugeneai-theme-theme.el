;;; package --- A beautiful theme

;;; Commentary:

;;; Code:

(deftheme eugeneai-theme
  "Wheat color based theme, stolen in internet 2013-10-13.")

(custom-theme-set-variables
 'eugeneai-theme
 '(safe-local-variable-values (quote ((TeX-master . "dis") (py-master-file . "/path/to/interactivetest.py") (whitespace-line-column . 80) (lexical-binding . t))))
 '(show-paren-mode t)
 '(tool-bar-mode nil))

(custom-theme-set-faces
 'eugeneai-theme
 '(flyspell-duplicate ((t (:foreground "pale green"))))
 '(flyspell-incorrect ((t (:foreground "orange red"))))
 '(linum ((t (:inherit (shadow default) :background "black" :foreground "gold"))))
 '(region ((((class color) (min-colors 88) (background dark)) (:background "orange3"))))
 '(tex-verbatim ((t (:family "Ubuntu Mono"))))
 '(tooltip ((((class color)) (:inherit variable-pitch :background "lightyellow" :foreground "black" :height 0.5))))
 '(default ((t (:inherit nil :stipple nil :background "gray20" :foreground "wheat1" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 151 :width normal :foundry "unknown" :family "Fira Mono Regular"))))
 '(font-latex-verbatim-face ((t (:inherit Fira Sans Mono :foreground "burlywood"))))
 '(js2-external-variable ((t (:foreground "orange" :slant italic))))
 '(js2-function-call ((t (:inherit default))))
 '(minibuffer-prompt ((t (:foreground "CadetBlue1"))))
 '(mode-line ((t (:background "gray75" :foreground "black" :weight normal :height 0.6 :family "Source code pro"))))
 '(mode-line-highlight ((t (:background "gold"))))
 '(hl-line ((t (:inherit highlight :background "black"))))
 '(tex-verbatim ((t (:family "Inconsolata LGC Medium")))))



(provide-theme 'eugeneai-theme)
;;; eugeneai-theme-theme.el ends here
