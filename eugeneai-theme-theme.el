;;; package --- A beautiful theme

;;; Commentary:

;;; Code:

(deftheme eugeneai-theme
  "Wheat color based theme, stolen in internet 2013-10-13.")

(custom-theme-set-variables
 'eugeneai-theme
 '(safe-local-variable-values (quote ((TeX-master . "dis") (whitespace-line-column . 80) (lexical-binding . t))))
 '(show-paren-mode t))

(custom-theme-set-faces
 'eugeneai-theme
 '(flyspell-duplicate ((t (:foreground "pale green"))))
 '(flyspell-incorrect ((t (:foreground "orange red"))))
 '(linum ((t (:inherit (shadow default) :background "black" :foreground "gold"))))
 '(region ((((class color) (min-colors 88) (background dark)) (:background "orange3"))))
 '(tex-verbatim ((t (:family "Ubuntu Mono"))))
 '(tooltip ((((class color)) (:inherit variable-pitch :background "lightyellow" :foreground "black" :height 0.5))))
 ;'(default ((t (:inherit nil :stipple nil :background "gray20" :foreground "wheat1" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 151 :width normal :foundry "unknown" :family "Fira Mono Regular"))))
 '(default ((t (:inherit nil :stipple nil :background "gray20" :foreground "LightCyan3" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 151 :width normal :foundry "unknown" :family "Fira Mono Regular"))))
 '(font-latex-verbatim-face ((t (:inherit Fira Sans Mono :foreground "burlywood"))))
 '(js2-external-variable ((t (:foreground "orange" :slant italic))))
 '(js2-function-call ((t (:inherit default))))
 '(minibuffer-prompt ((t (:foreground "CadetBlue1"))))
 '(mode-line ((t (:background "gray75" :foreground "black" :weight normal :height 0.85 :family "Source code pro"))))
 '(mode-line-highlight ((t (:background "gold"))))
 '(hl-line ((t (:inherit highlight :background "black"))))
 '(tex-verbatim ((t (:family "Inconsolata LGC Medium"))))

 '(company-preview
   ((t (:inherit default :foreground "darkgray" :height 110))))
 '(company-preview-common
   ((t (:inherit default :foreground "bisque1" :distant-foreground "blue"))))
 '(company-tooltip
   ((t (:inherit company-preview :background "lightgray" :foreground "black"))))
 '(company-tooltip-selection
   ((t (:inherit company-preview :background "steelblue" :foreground "white"))))

 '(company-tooltip-common
   ((((type x)) (:inherit company-tooltip :foreground "white" :background "olive drab"))
    (t (:inherit company-tooltip))))
 '(company-tooltip-common-selection
   ((((type x)) (:inherit company-tooltip-selection :background "blue"))
    (t (:inherit company-tooltip-selection))))

 '(company-tooltip-annotation
   ((t (:inherit company-tooltip :foreground "saddle brown"))))
 '(company-tooltip-annotation-selection
   ((t (:inherit company-tooltip-selection :foreground "sandy brown"))))

 )


(provide-theme 'eugeneai-theme)
;;; eugeneai-theme-theme.el ends here
