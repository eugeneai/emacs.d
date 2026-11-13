# Key bindings

Generated from `init.el` (Emacs 31.1).

| Key | Command | Description | Where |
|---|---|---|---|
| `<f1>` | `my/smart-bookmark-set` | Set bookmark with intelligent default name. | global |
| `C-%` | `isearch-query-replace-regexp` | Start ‘query-replace-regexp’ with string to replace from last search string. | isearch |
| `C-.` | `embark-act` | Prompt the user for an action and perform it. | global |
| `C-;` | `embark-dwim` | Run the default action on the current target. | global |
| `C-<` | `mc/mark-previous-like-this` | Find and mark the previous part of the buffer matching the | global |
| `C-<f1>` | `my/quick-bookmark-jump` | Quick jump to bookmark with completion. | global |
| `C-<return>` | `yas-expand-from-trigger-key` | Expand a snippet before point. | global |
| `C-<tab>` | `file-cache-minibuffer-complete` | Complete a filename in the minibuffer using a preloaded cache. | minibuffer |
| `C->` | `mc/mark-next-like-this` | Find and mark the next part of the buffer matching the currently active region | global |
| `C-\` | `sync-with-system-layout` | Sync Emacs input method with system keyboard layout. | global |
| `C-^` | `isearch-toggle-specified-input-method` | Select an input method and turn it on in interactive search. | isearch |
| `C-_` | `undo-fu-only-undo` | Undo the last action. | global |
| `C-a` | `beginning-of-line-or-indentation` | Move to beginning of line, or indentation. | global |
| `C-c +` | `text-scale-increase` | Increase the font size of the default face in current buffer by INC steps. | global |
| `C-c -` | `text-scale-decrease` | Decrease the font size of the default face in the current buffer by DEC steps. | global |
| `C-c 0` | `text-scale-adjust` | Adjust the font size in the current buffer by INC steps. | global |
| `C-c C-<` | `mc/mark-all-like-this` | Find and mark all the parts of the buffer matching the currently active region | global |
| `C-c b` | `big-font-mode` | Большой шрифт для проектора. | global |
| `C-c m` | `normal-font-mode` | Нормальный размер шрифта. | global |
| `C-d` | `isearch-del-char` | Delete character from end of search string and search again. | isearch |
| `C-e` | `isearch-yank-line` | Pull rest of line from buffer into search string. | isearch |
| `C-g` | `minibuffer-keyboard-quit` | Abort recursive edit. | minibuffer |
| `C-h` | `isearch-help-for-help` | Display Isearch help menu. | isearch |
| `C-j` | `exit-minibuffer` | Terminate this minibuffer argument. | minibuffer |
| `C-o` | `open-line-below` | Новая строка под текущей: в конец строки + RET с отступом. | global |
| `C-q` | `isearch-quote-char` | Quote special characters for incremental search. | isearch |
| `C-r` | `isearch-backward` | Do incremental search backward. | global |
| `C-s` | `consult-line` | Search for a matching line. | global |
| `C-w` | `isearch-yank-word-or-char` | Pull next character or word from buffer into search string. | isearch |
| `C-x !` | `shell` | Run an inferior shell, with I/O through BUFFER (which defaults to ‘*shell*’). | global |
| `C-x C-\` | `consult-mark` | Jump to a marker in MARKERS list (defaults to buffer-local ‘mark-ring’). | global |
| `C-x C-b` | `consult-buffer` | Enhanced ‘switch-to-buffer’ command with support for virtual buffers. | global |
| `C-x C-j` | `dired-at-point` | Start Dired, defaulting to file at point.  See ‘ffap’. | global |
| `C-x C-k` | `kill-current-buffer` | Kill the current buffer. | global |
| `C-x M-r` | `recentf-open-files` | Show a dialog to open a recent file. | global |
| `C-x b` | `consult-buffer` | Enhanced ‘switch-to-buffer’ command with support for virtual buffers. | global |
| `C-x c` | `compile` | Compile the program including the current buffer.  Default: run ‘make’. | global |
| `C-x e` | `erase-buffer` | Delete the entire contents of the current buffer. | global |
| `C-x g` | `magit-status` | Show the status of the current Git repository in a buffer. | global |
| `C-y` | `isearch-yank-kill` | Pull string from kill ring into search string. | isearch |
| `C-z` | `undo-fu-only-undo` | Undo the last action. | global |
| `C-|` | `beginning-of-buffer` | Move point to the beginning of the buffer. | global |
| `C-}` | `end-of-buffer` | Move point to the end of the buffer. | global |
| `DEL` | `isearch-delete-char` | Undo last input item during a search. | isearch |
| `ESC` | `isearch-cancel` | Terminate the search and go back to the starting point. | isearch |
| `M-.` | `embark-act` | Prompt the user for an action and perform it. | global |
| `M-<down>` | `minibuffer-next-completion` | Move to the next item in its completions window from the minibuffer. | minibuffer |
| `M-<up>` | `drag-stuff-up` | Drag stuff ARG lines up. | global |
| `M-A` | `mark-whole-buffer` | Put point at beginning and mark at end of buffer. | global |
| `M-I` | `consult-imenu` | Select item from flattened ‘imenu’ using ‘completing-read’ with preview. | global |
| `M-RET M-RET` | `gptel-aibo-send` | Send the current context and request to GPT for processing. | global |
| `M-RET g d` | `external-difftool-current-file` | Open current file in external diff tool against last commit. | global |
| `M-RET g p` | `external-difftool-current-file-prevversion` | Open current file in external diff tool against previous version (HEAD~1). | global |
| `M-RET g s` | `gptel-send` | Submit this prompt to the current LLM backend. | global |
| `M-RET m s` | `magit-status` | Show the status of the current Git repository in a buffer. | global |
| `M-RET s g` | `consult-git-grep` | Search with ‘git grep’ for files in DIR with INITIAL input. | global |
| `M-RET s r` | `consult-ripgrep` | Search with ‘rg’ for files in DIR with INITIAL input. | global |
| `M-RET` | `prefix map` |  | global |
| `M-_` | `undo-fu-only-redo` | Redo an action until the initial undo action. | global |
| `M-g M-g` | `consult-goto-line` | Read line number and jump to the line with preview. | global |
| `M-g g` | `consult-goto-line` | Read line number and jump to the line with preview. | global |
| `M-i` | `my/occur-at-point` | Показать совпадения по символу под курсором (или спросить). | global |
| `M-o` | `open-line-above` | Новая строка над текущей: в начало строки + RET с отступом. | global |
| `M-p` | `er/expand-region` | Increase selected region by semantic units. | global |
| `M-y` | `consult-yank-pop` | If there is a recent yank act like ‘yank-pop’. | global |
| `RET` | `exit-minibuffer` | Terminate this minibuffer argument. | minibuffer |
| `S-SPC` | `isearch-printing-char` | Add this ordinary printing CHAR to the search string and search. | isearch |
| `SPC` | `minibuffer-complete-word` | Complete the minibuffer contents at most a single word. | minibuffer |
| `TAB` | `self-insert-command` | Insert the character you type. | minibuffer |
| `s-z` | `switch-window` | Display an overlay in each window showing a unique key. | global |
