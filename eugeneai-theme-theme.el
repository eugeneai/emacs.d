;;; -*- lexical-binding: t; -*-
;;; package --- A beautiful theme

;;; Commentary:

;; Цвета в терминале и в GUI заданы раздельно: (type tty) / (type x).
;;
;; GUI — как исторически было в eugeneai-theme (wheat-вариант).
;;
;; TTY — палитра «andreas» (port из color-themes для color-theme-modern):
;; белый фон, чёрный текст, красные ключевые слова, зелёные строки,
;; синие имена функций, оранжевые комментарии, жёлтое выделение.
;; Взято из проекта color-theme-modern (GPLv3), поэтому только имена цветов
;; xterm-256, которые в палитре терминала попадают без потерь.
;;
;; Шрифты (family/height) в tty игнорируются, поэтому для tty не задаются.

;;; Code:

(deftheme eugeneai-theme
  "Wheat color based theme, stolen in internet 2013-10-13.")

(custom-theme-set-variables
 'eugeneai-theme
 '(safe-local-variable-values (quote ((TeX-master . "dis") (whitespace-line-column . 80) (lexical-binding . t))))
 '(show-paren-mode t))

(custom-theme-set-faces
 'eugeneai-theme

 ;; ------------------------------------------------------------------
 ;; Базовые цвета: GUI — wheat, tty — andreas (чёрный по белому).
 ;; ------------------------------------------------------------------
 '(default ((((type tty)) (:background "white" :foreground "black"))
            (t (:inherit nil :stipple nil :background "gray20" :foreground "LightCyan3"
                         :inverse-video nil :box nil :strike-through nil :overline nil
                         :underline nil :slant normal :weight normal :height 151 :width normal))))
 '(cursor ((((type tty)) (:background "black"))
            (t (:background "LightCyan3"))))
 '(region ((((type tty) (min-colors 256)) (:background "gray75" :foreground "black"))
           (((class color) (min-colors 88) (background dark)) (:background "orange3"))
           (t (:background "deep sky blue" :foreground "black"))))
 '(secondary-selection ((((type tty)) (:background "paleturquoise" :foreground "black"))
                        (t (:background "SteelBlue4" :foreground "white"))))
 '(highlight ((((type tty)) (:background "yellow" :foreground "red"))
              (t (:background "yellow" :foreground "black"))))
 ;; foreground обязателен: без него hl-line/isearch наследуют :foreground от
 ;; highlight/hl-line-родственных лиц и текст сливается с фоном.
 '(hl-line ((((type tty)) (:background "gray95" :foreground "black"))
            (t (:background "black" :foreground "LightCyan3"))))
 '(lazy-highlight ((((type tty)) (:background "yellow" :foreground "red"))
                   (t (:background "yellow" :foreground "black"))))
 '(isearch ((((type tty)) (:background "yellow" :foreground "red"))
            (t (:background "orange3" :foreground "black"))))
 '(match ((((type tty)) (:background "yellow" :foreground "red"))
          (t (:background "gold" :foreground "black"))))

 ;; ------------------------------------------------------------------
 ;; Подсветка синтаксиса (font-lock) — tty как в andreas.
 ;; ------------------------------------------------------------------
 '(font-lock-comment-face ((((type tty)) (:foreground "orange1"))
                           (t (:foreground "gray70"))))
 '(font-lock-comment-delimiter-face ((((type tty)) (:foreground "orange1"))
                                    (t (:inherit font-lock-comment-face))))
 '(font-lock-doc-face ((((type tty)) (:foreground "green4"))
                       (t (:foreground "burlywood"))))
 '(font-lock-string-face ((((type tty)) (:foreground "green4"))
                          (t (:foreground "burlywood"))))
 '(font-lock-doc-string-face ((((type tty)) (:foreground "green4"))
                              (t (:foreground "burlywood"))))
 '(font-lock-keyword-face ((((type tty)) (:foreground "red1"))
                           (t (:foreground "CadetBlue1"))))
 '(font-lock-builtin-face ((((type tty)) (:foreground "red1"))
                           (t (:foreground "CadetBlue1"))))
 '(font-lock-function-name-face ((((type tty)) (:foreground "blue3"))
                                 (t (:foreground "SkyBlue1"))))
 '(font-lock-variable-name-face ((((type tty)) (:foreground "blue3"))
                                 (t (:foreground "LightCyan3"))))
 '(font-lock-preprocessor-face ((((type tty)) (:foreground "blue3"))
                                (t (:foreground "CadetBlue1"))))
 '(font-lock-reference-face ((((type tty)) (:foreground "red3"))
                             (t (:foreground "orange red"))))
 '(font-lock-type-face ((((type tty)) (:foreground "#6920ac"))
                        (t (:foreground "Plum1"))))
 '(font-lock-constant-face ((((type tty)) (:foreground "#6920ac"))
                            (t (:foreground "Plum1"))))
 '(font-lock-warning-face ((((type tty)) (:weight bold :foreground "red"))
                           (t (:weight bold :foreground "orange red"))))

 ;; ------------------------------------------------------------------
 ;; Интерфейс
 ;; ------------------------------------------------------------------
 '(mode-line ((((type tty)) (:background "gray75" :foreground "black" :weight normal))
              (t (:background "gray75" :foreground "black" :weight normal
                              :height 0.85 :family "Source code pro"))))
 '(mode-line-buffer-id ((((type tty)) (:background "gray75" :foreground "blue4"))
                        (t (:foreground "black" :weight bold))))
 '(mode-line-highlight ((t (:background "gold"))))
 ;; mode-line-active и header-line наследуются от mode-line, иначе в терминале
 ;; они перетягивают значения из custom.el (чёрная строка заголовка).
 '(mode-line-active ((t (:inherit mode-line))))
 '(header-line ((t (:inherit mode-line))))
 '(mode-line-inactive ((((type tty)) (:background "gray65" :foreground "black"))
                       (t (:inherit mode-line :background "gray40"))))
 '(minibuffer-prompt ((((type tty)) (:foreground "red3" :weight bold))
                      (t (:foreground "CadetBlue1"))))
 '(linum ((((type tty)) (:background "white" :foreground "gray68"))
          (t (:inherit (shadow default) :background "black" :foreground "gold"))))
 '(fringe ((((type tty)) (:background "white"))
           (t (:background "gray20"))))
 '(vertical-border ((((type tty)) (:foreground "gray80"))
                    (t (:foreground "gray50"))))
 '(tooltip ((((class color)) (:inherit variable-pitch :background "lightyellow"
                                     :foreground "black" :height 0.5))))
 '(show-paren-match ((((type tty)) (:background "red" :foreground "white"))
                     (t (:background "orange3" :foreground "black"))))
 '(show-paren-mismatch ((((type tty)) (:background "DeepPink" :foreground "white"))
                        (t (:background "orange red" :foreground "white"))))

 ;; ------------------------------------------------------------------
 ;; Проверка орфографии, LaTeX, прочее
 ;; ------------------------------------------------------------------
 '(flyspell-duplicate ((((type tty)) (:underline t :foreground "orange1"))
                       (t (:foreground "pale green"))))
 '(flyspell-incorrect ((((type tty)) (:underline t :foreground "red1"))
                       (t (:foreground "orange red"))))
 '(tex-verbatim ((((type tty)) (:foreground "green4"))
                 (t (:family "Inconsolata LGC Medium"))))
 '(font-latex-verbatim-face ((((type tty)) (:foreground "green4"))
                             (t (:inherit Fira Sans Mono :foreground "burlywood"))))
 '(js2-external-variable ((t (:foreground "orange" :slant italic))))
 '(js2-function-call ((t (:inherit default))))

 ;; ------------------------------------------------------------------
 ;; Company: в tty тултип в стиле andreas (светло-серое на чёрном).
 ;; ------------------------------------------------------------------
 '(company-preview
   ((((type tty)) (:background "gray90" :foreground "black"))
    (t (:inherit default :foreground "darkgray" :height 110))))
 '(company-preview-common
   ((t (:inherit default :foreground "bisque1" :distant-foreground "blue"))))
 '(company-tooltip
   ((((type tty)) (:background "gray90" :foreground "black"))
    (t (:inherit company-preview :background "lightgray" :foreground "black"))))
 '(company-tooltip-selection
   ((((type tty)) (:background "yellow" :foreground "red"))
    (t (:inherit company-preview :background "steelblue" :foreground "white"))))
 '(company-tooltip-common
   ((((type tty)) (:inherit company-tooltip :foreground "blue3" :weight bold))
    (t (:inherit company-tooltip :foreground "white" :background "olive drab"))))
 '(company-tooltip-common-selection
   ((((type tty)) (:inherit company-tooltip-selection :foreground "blue3" :weight bold))
    (t (:inherit company-tooltip-selection :background "blue"))))
 '(company-tooltip-annotation
   ((((type tty)) (:inherit company-tooltip :foreground "green4"))
    (t (:inherit company-tooltip :foreground "saddle brown"))))
 '(company-tooltip-annotation-selection
   ((((type tty)) (:inherit company-tooltip-selection :foreground "green4"))
    (t (:inherit company-tooltip-selection :foreground "sandy brown"))))
 )

(provide-theme 'eugeneai-theme)
;;; eugeneai-theme-theme.el ends here
