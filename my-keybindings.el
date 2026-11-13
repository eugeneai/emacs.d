;; -*- lexical-binding: t; -*-
;; Генератор справочника клавиш: init.el -> keybindings.md
;;
;; Показываются только комбинации, заданные в конфиге (global-set-key,
;; keymap-global-set, :bind, :bind-keymap), плюс переопределённые клавиши
;; отдельных карт (minibuffer, isearch, org, markdown, python, LaTeX).

(require 'cl-lib)

(defvar my-keys/managed (expand-file-name "init.el" user-emacs-directory)
  "Файл конфигурации, из которого берутся определения.")

(defvar my-keys/output (expand-file-name "keybindings.md" user-emacs-directory)
  "Куда писать справочник.")

(defvar my-keys/extra-maps
  '((minibuffer-local-map . "minibuffer")
    (minibuffer-local-completion-map . "minibuffer")
    (isearch-mode-map . "isearch")
    (org-mode-map . "org")
    (markdown-mode-map . "markdown")
    (python-mode-map . "python")
    (LaTeX-mode-map . "LaTeX"))
  "Дополнительные карты, для которых выводим отличия от глобальных.")

(defvar my-keys/known nil
  "Хеш-таблица «клавиша -> t» для ключей, заданных в init.el.")

;; ---------------------------------------------------------------------------
;; 1. Сбор ключей, упомянутых в конфиге
;; ---------------------------------------------------------------------------

(defun my-keys/mark (key)
  "Запомнить KEY."
  (when (not my-keys/known)
    (setq my-keys/known (make-hash-table :test 'equal)))
  (puthash (key-description (if (vectorp key) key (kbd key))) t my-keys/known))

(defun my-keys/mark-if-literal (key)
  "Отметить KEY, если это литерал."
  (cond
   ((stringp key) (my-keys/mark key))
   ((and (consp key) (eq (car key) 'kbd) (stringp (cadr key)))
    (my-keys/mark (cadr key)))
   ((vectorp key) (my-keys/mark key))))

(defun my-keys/string-key-p (x)
  "X — строка-клавиша (\"C-x o\"), а не символ."
  (stringp x))

(defun my-keys/kbd-string (key)
  "Строка-клавиша из KEY (символа, строки или вектора)."
  (cond
   ((stringp key) key)
   ((symbolp key) (symbol-name key))
   ((vectorp key) (key-description key))
   (t (format "%s" key))))

(defun my-keys/scan-bind (spec)
  "Разобрать :bind SPEC — список пар или плейлист с :map."
  (cond
   ((null spec) nil)
   ((eq (car spec) :map)
    (my-keys/scan-bind (cddr spec)))
   ;; Плотная пара ("клавиша" . команда): (cdr spec) — символ.
   ((and (consp spec) (stringp (car spec)))
    (my-keys/mark (car spec)))
   ((consp (car spec))
    (my-keys/mark-if-literal (car (car spec)))
    (my-keys/scan-bind (cdr spec)))
   (t nil)))

(defun my-keys/scan-plist (args)
  "Разобрать аргументы use-package: :bind, :bind-keymap."
  (let ((rest args))
    (while (and rest (consp rest))
      (cond
       ;; Плотная пара ("C-x o" . command) — остаток плейлиста :bind.
       ((and (stringp (car rest)) (not (keywordp (car rest))))
        (my-keys/mark (car rest))
        (setq rest nil))
       ((eq (car rest) :bind)
        (my-keys/scan-bind (cdr rest))
        (setq rest nil))
       (t (setq rest (cdr rest)))))))

(defun my-keys/scan-forms (forms)
  "Просмотреть FORMS на вложенные определения клавиш."
  (dolist (form forms)
    (when (consp form)
      (my-keys/scan-form form))))

(defun my-keys/scan-form (form)
  "Найти ключи в FORM из init.el."
  (pcase form
    (`(,(or 'global-set-key 'keymap-global-set 'define-key 'keymap-set)
       ,key ,_binding)
     (my-keys/mark-if-literal key))
    (`(use-package ,_pkg . ,args)
     (my-keys/scan-plist args))
    (`(,(or 'with-eval-after-load 'eval-after-load) ,_feature . ,body)
     (mapc #'my-keys/scan-form body))
    (`(progn . ,body)
     (mapc #'my-keys/scan-form body))
    (_ nil)))

(defun my-keys/scan-forms-deep (forms)
  "Просмотреть FORMS, включая тела :init/:config внутри use-package."
  (dolist (form forms)
    (when (consp form)
      (cond
       ((eq (car form) 'use-package)
        (my-keys/scan-plist (cddr form))
        (let ((rest (cddr form)))
          (while rest
            (when (and (consp (cdr rest))
                       (memq (car rest) '(:init :config))
                       (listp (cadr rest)))
              (my-keys/scan-forms-deep (cadr rest)))
            (setq rest (cdr rest)))))
       (t (my-keys/scan-form form))))))

(defun my-keys/scan-file ()
  "Прочитать init.el и собрать ключи."
  (setq my-keys/known (make-hash-table :test 'equal))
  (with-temp-buffer
    (insert-file-contents my-keys/managed)
    (goto-char (point-min))
    (let (forms)
      (condition-case nil
          (while t (push (read (current-buffer)) forms))
        (end-of-file nil))
      (my-keys/scan-forms-deep (nreverse forms))))
  my-keys/known)

;; ---------------------------------------------------------------------------
;; 2. Текущие биндинги
;; ---------------------------------------------------------------------------

(defun my-keys/describe (cmd)
  "Первая строка документации CMD или пустая строка.
Догадывается о смысле для анонимных лямбд из use-package."
  (let ((doc (and (symbolp cmd) (fboundp cmd) (documentation cmd))))
    (replace-regexp-in-string
     "[|\n]" " "
     (cond
      (doc (car (split-string doc "\n")))
      ((eq cmd '+prefix) "")
      (t "")))))

(defun my-keys/name (def)
  "Имя для DEF (команда, префикс или анонимная лямбда)."
  (cond
   ((keymapp def) "prefix map")
   ((symbolp def) (symbol-name def))
   ((consp def) "lambda")
   (t "?")))

(defun my-keys/row (key cmd doc where)
  "Строка таблицы."
  (format "| `%s` | `%s` | %s | %s |\n" key cmd doc where))

(defun my-keys/row-for (key def where)
  "Строка таблицы для DEF с ключом KEY."
  (my-keys/row key (my-keys/name def) (my-keys/describe def) where))

(defun my-keys/self-insert-p (def)
  "DEF — self-insert-command или его символический эквивалент."
  (or (eq def 'self-insert-command)
      (and (symbolp def) (string-match-p "\\`self-insert" (symbol-name def)))))

(defun my-keys/key-combo-p (key)
  "KEY — осмысленное сочетание (C-, M-, S-, RET, TAB, ESC, C-c-префикс).
Псевдоклавиши вида <left> и одиночные символы режимов (org, markdown)
не показываем: это внутренняя механика режима, а не наша настройка."
  (and (>= (length key) 3)
       (or (string-match-p "\\`\\(C-\\|M-\\|S-\\)" key)
           (member key '("RET" "TAB" "ESC" "DEL" "SPC")))))

(defvar my-keys/skip-submaps
  '((org-mode-map . ("C-c"))
    (default . ("C-c")))
  "Подкарты, которые не расшифровываем: их содержимое — механика пакета,
а не наши сочетания клавиш.")

(defun my-keys/extra-rows (map name seen &optional skip)
  "Строки для отличий MAP от глобальной карты.
Показываются только сочетания с модификаторами или C-c/префиксами,
а не одиночные символы режима (org и т.п.)."
  (let (rows)
    (map-keymap
     (lambda (event def)
       (let* ((vec (vector event))
              (key (key-description vec))
              (global (lookup-key (current-global-map) vec)))
         (when (and (keymapp def) (not (member key skip)))
           (setq rows (append rows (my-keys/extra-rows
                                    (cons 'keymap def) name seen skip))))
         (when (and (symbolp def) (commandp def)
                    (not (string-prefix-p "<" key))
                    (my-keys/key-combo-p key)
                    (not (eq def global))
                    (not (gethash key seen)))
           (puthash key t seen)
           (push (my-keys/row-for key def name) rows))))
     (cons 'keymap map))
    rows))

(defun my-keys/collect ()
  "Собрать строки таблицы."
  (let ((rows nil)
        (seen (make-hash-table :test 'equal)))
    (maphash
     (lambda (key _)
       (let ((def (lookup-key (current-global-map) (kbd key))))
         (cond
          ((and (symbolp def) (commandp def))
           (push (my-keys/row-for key def "global") rows)
           (puthash key t seen))
          ((keymapp def)
           (push (my-keys/row key "prefix map" "" "global") rows)
           (puthash key t seen)))))
     my-keys/known)
    (dolist (pair my-keys/extra-maps)
      (let ((map (and (boundp (car pair)) (symbol-value (car pair)))))
        (when (keymapp map)
          (let ((skip (or (cdr (assoc (car pair) my-keys/skip-submaps))
                          (cdr (assoc 'default my-keys/skip-submaps)))))
            (dolist (row (my-keys/extra-rows map (cdr pair) seen skip))
              (setq rows (cons row rows)))))))
    (sort rows #'string<)))

;; ---------------------------------------------------------------------------
;; 3. Запись
;; ---------------------------------------------------------------------------

(defun my-keys/write ()
  "Записать keybindings.md."
  (let ((rows (my-keys/collect))
        (coding-system-for-write 'utf-8-unix)
        (inhibit-message t))
    (with-temp-buffer
      (insert (format "# Key bindings\n\nGenerated from `%s` (Emacs %s).\n\n"
                      (file-relative-name my-keys/managed "~/.emacs.d/")
                      emacs-version))
      (insert "| Key | Command | Description | Where |\n|---|---|---|---|\n")
      (mapc #'insert rows)
      (write-region (point-min) (point-max) my-keys/output nil 'silent))
    (message "keybindings: %d -> %s" (length rows) my-keys/output)))

(defun my-keys/generate ()
  "Перегенерировать справочник клавиш."
  (interactive)
  (my-keys/scan-file)
  (my-keys/write))

(provide 'my-keybindings)
