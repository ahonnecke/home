;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Ashton Honnecke"
      user-mail-address "ashton@pixelstub.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.


;; (defun contextual:find-file ()
;;   (interactive)
;;   (call-interactively (if (projectile-project-p)
;;                           'projectile-find-file
;;                         'helm-find-files)))
;;(define-key global-map (kbd "C-x f") 'helm-find-files)

;;(define-key projectile-mode-map (kbd "H-p") 'projectile-command-map)
;;(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

;; get back
(global-set-key (kbd "H-p p") 'projectile-switch-project)

(global-set-key (kbd "<C-next>") 'windmove-right)
(global-set-key (kbd "<C-prior>") 'windmove-left)

;;(define-key projectile-mode-map (kbd "C-x f") 'helm-find-files)
;;(define-key global-map (kbd "C-x C-f") 'contextual:find-file)
;; (define-key projectile-mode-map (kbd "M-r a") 'ag-regexp-project-at-point)
;; (define-key projectile-mode-map (kbd "M-r r") 'ag-project-regexp)

;; (global-set-key (kbd "C-c h") 'dash-at-point)
;; ;(global-set-key (kbd "C-M-d") 'dash-at-point)

;; ;;(setq switch-to-ag-buffer
;; ;;      [?\C-x ?b ?* ?a ?g ?  ?s ?e ?a ?r ?c ?h ?* return])
;; ;(define-key projectile-mode-map [?\s-c] 'switch-to-ag-buffer)
;; ;;(global-set-key (kbd "C-c p") 'switch-to-ag-buffer)

;; ;(global-set-key (kbd "M-<return>") 'hippie-expand)
(global-set-key (kbd "H-; c") 'comment-region)
(global-set-key (kbd "H-; u c") 'uncomment-region)

(global-set-key (kbd "M-<return>") 'hippie-expand)

;; Go to line number
(global-set-key (kbd "H-l") 'goto-line)

;; Go to visible line with home row keys
;;(global-set-key (kbd "H-l") 'avy-goto-line)

;;e
;;(global-set-key (kbd "C-c r") 'replace-string)
(global-set-key (kbd "H-q") 'query-replace)

(global-set-key (kbd "H-s") 'swiper-thing-at-point)
(global-set-key (kbd "M-u") 'string-inflection-python-style-cycle)

(global-set-key (kbd "C-x c p") 'string-inflection-python-style-cycle)
(global-set-key (kbd "C-x c a") 'string-inflection-all-cycle)
(global-set-key (kbd "C-x c s") 'string-inflection-underscore)
(global-set-key (kbd "C-x c u") 'string-inflection-upcase)

(global-set-key (kbd "C-<right>") 'python-indent-shift-right)
(global-set-key (kbd "C-<left>") 'python-indent-shift-left)

(global-set-key (kbd "C-s") 'isearch-forward)
;; (key-chord-define-global ";j" 'avy-goto-char)
;;f
(global-set-key (kbd "s-f") 'forward-sexp)
(global-set-key (kbd "s-b") 'backward-sexp)
(global-set-key (kbd "C-x k") 'kill-this-buffer)
(global-set-key (kbd "C-x C-k") 'kill-buffer)
(global-set-key (kbd "H-y") 'ace-window)
(global-set-key (kbd "H-u") 'ace-swap-window)
;; (key-chord-define-global ";a" 'ace-window)
;; (key-chord-define-global ";s" 'ace-swap-window)
;; (key-chord-define-global ";u" 'undo)
;; (key-chord-define-global ";k" 'kill-buffer)
;; (key-chord-define-global "'." 'ace-jump-mode) ;; select characters to jump to
;; ;;(key-chord-define-global "''" 'save-buffer)
;; (key-chord-define-global ";c" 'string-inflection-all-cycle)
(global-set-key (kbd "H-.") 'end-of-buffer)
(global-set-key (kbd "H-,") 'beginning-of-buffer)
(global-set-key (kbd "C-c d") 'crux-duplicate-current-line-or-region)
(global-set-key (kbd "H-; d") 'crux-duplicate-current-line-or-region)

;; ;;(global-set-key (kbd "M-o") (quote ace-window))
;; (define-key shell-mode-map (kbd "M-o") (quote ace-window))

;; (define-key shell-mode-map (kbd "C-x o") (quote ace-window))
;; (global-set-key (kbd "C-x o") (quote ace-window))

;; ;;(global-set-key (kbd "H-o") (quote ace-window))

;;(global-set-key (kbd "H-r") 'crux-recentf-find-file)
(global-set-key (kbd "H-f") 'helm-projectile-find-file)
(global-set-key (kbd "H-r") 'recentf-open-files)

(global-set-key (kbd "H-j") 'crux-top-join-line)
(global-set-key (kbd "H-k") 'crux-kill-whole-line)
(global-set-key (kbd "H-m m") 'magit-status)
(global-set-key (kbd "H-m l") 'magit-log)
(global-set-key (kbd "H-m f") 'magit-log-buffer-file)
(global-set-key (kbd "H-m b") 'magit-blame)
(global-set-key (kbd "H-o") 'crux-smart-open-line-above)

(global-set-key (kbd "H-C-f") 'find-file)
;;(global-set-key (kbd "H-f") 'fzf)
(global-set-key (kbd "H-o") 'browse-url-at-point)

(global-set-key (kbd "C-w") 'kill-region)

;;(global-set-key (kbd "M-l") 'goto-line)
(global-set-key (kbd "C-l") 'recenter-top-bottom)

(global-set-key (kbd "H-; l") 'flycheck-list-errors)

(global-set-key (kbd "C-;") 'er/expand-region)
;;(define-key flyspell-mode-map (kbd "C-;") 'er/expand-region)

(global-set-key (kbd "H-<right>") 'windmove-right)
(global-set-key (kbd "H-<left>") 'windmove-left)
(global-set-key (kbd "H-<up>") 'windmove-up)
(global-set-key (kbd "H-<down>") 'windmove-down)

(fset 'triple-screen
      (lambda (&optional arg)
        "Split the screen into three screens"
        (interactive "p")
        (kmacro-exec-ring-item
         (quote ([?\C-x ?1 ?\C-x ?3 ?\C-x ?3 ?\C-x ?+ ] 0 "%d")) arg)))

(fset 'quad-screen
      (lambda (&optional arg)
        "Split the screen into four bufers"
        (interactive "p")
        (kmacro-exec-ring-item
         (quote ([?\C-x ?1 ?\C-x ?3 ?\C-x ?3 ?\C-x ?3 ?\C-x ?+ ] 0 "%d")) arg)))

(global-set-key (kbd "C-c +") 'quad-screen)

;; Global config
;;

;; DefBindings
;; Unbind unneeded keys
(global-set-key (kbd "C-z") nil)
(global-set-key (kbd "M-z") nil)
(global-set-key (kbd "M-m") nil)
(global-set-key (kbd "C-x C-z") nil)
(global-set-key (kbd "M-/") nil)
;; Truncate lines
(global-set-key (kbd "C-x C-l") #'toggle-truncate-lines)
;; Adjust font size like web browsers
(global-set-key (kbd "C-=") #'text-scale-increase)
(global-set-key (kbd "C-+") #'text-scale-increase)
(global-set-key (kbd "C--") #'text-scale-decrease)
;; Move up/down paragraph
(global-set-key (kbd "M-n") #'forward-paragraph)
(global-set-key (kbd "M-p") #'backward-paragraph)
;; -DefBindings

;; UTF8Coding
;; (unless *sys/win32*
;;   (set-selection-coding-system 'utf-8)
;;   (prefer-coding-system 'utf-8)
;;   (set-language-environment "UTF-8")
;;   (set-default-coding-systems 'utf-8)
;;   (set-terminal-coding-system 'utf-8)
;;   (set-keyboard-coding-system 'utf-8)
;;   (setq locale-coding-system 'utf-8))
;; ;; Treat clipboard input as UTF-8 string first; compound text next, etc.
;; (when (display-graphic-p)
;;   (setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING)))
;; -UTF8Coding

;; EditExp
;; Remove useless whitespace before saving a file
(defun delete-trailing-whitespace-except-current-line ()
  "An alternative to `delete-trailing-whitespace'.

The original function deletes trailing whitespace of the current line."
  (interactive)
  (let ((begin (line-beginning-position))
        (end (line-end-position)))
    (save-excursion
      (when (< (point-min) (1- begin))
        (save-restriction
          (narrow-to-region (point-min) (1- begin))
          (delete-trailing-whitespace)
          (widen)))
      (when (> (point-max) (+ end 2))
        (save-restriction
          (narrow-to-region (+ end 2) (point-max))
          (delete-trailing-whitespace)
          (widen))))))

(defun smart-delete-trailing-whitespace ()
  "Invoke `delete-trailing-whitespace-except-current-line' on selected major modes only."
  (unless (member major-mode '(diff-mode))
    (delete-trailing-whitespace-except-current-line)))

(add-hook 'before-save-hook #'smart-delete-trailing-whitespace)

;; Replace selection on insert
(delete-selection-mode 1)

;; Map Alt key to Meta
(setq x-alt-keysym 'meta)
;; -EditExp

;; History
(use-package recentf
  :ensure nil
  :hook (after-init . recentf-mode)
  :custom
  (recentf-auto-cleanup "05:00am")
  (recentf-max-saved-items 200)
  (recentf-exclude '((expand-file-name package-user-dir)
                     ".cache"
                     ".cask"
                     ".elfeed"
                     "bookmarks"
                     "cache"
                     "ido.*"
                     "persp-confs"
                     "recentf"
                     "undo-tree-hist"
                     "url"
                     "COMMIT_EDITMSG\\'")))

;; When buffer is closed, saves the cursor location
(save-place-mode 1)

;; Set history-length longer
(setq-default history-length 500)
;; -History

;; SmallConfigs
;; Move the backup fies to user-emacs-directory/.backup
(setq backup-directory-alist `(("." . ,(expand-file-name ".backup" user-emacs-directory))))

;; Ask before killing emacs
(setq confirm-kill-emacs 'y-or-n-p)

;; Turn Off Cursor Alarms
(setq ring-bell-function 'ignore)

;; Show Keystrokes in Progress Instantly
(setq echo-keystrokes 0.1)

;; Don't Lock Files
(setq-default create-lockfiles nil)

;; Better Compilation
(setq-default compilation-always-kill t) ; kill compilation process before starting another

(setq-default compilation-ask-about-save nil) ; save all buffers on `compile'

(setq-default compilation-scroll-output t)

;; ad-handle-definition warnings are generated when functions are redefined with `defadvice',
;; they are not helpful.
(setq ad-redefinition-action 'accept)

;; Move Custom-Set-Variables to Different File
(setq custom-file (concat user-emacs-directory "custom-set-variables.el"))
(load custom-file 'noerror)

;; So Long mitigates slowness due to extremely long lines.
;; Currently available in Emacs master branch *only*!
(when (fboundp 'global-so-long-mode)
  (global-so-long-mode))

;; Add a newline automatically at the end of the file upon save.
(setq require-final-newline t)

;; Default .args, .in, .out files to text-mode
(add-to-list 'auto-mode-alist '("\\.in\\'" . text-mode))
(add-to-list 'auto-mode-alist '("\\.out\\'" . text-mode))
(add-to-list 'auto-mode-alist '("\\.args\\'" . text-mode))
;; -SmallConfigs

(global-set-key (kbd "H-g") 'helm-projectile-rg)

(add-to-list 'projectile-globally-ignored-directories "node_modules")
(setq projectile-indexing-method 'alien)

(setq projectile-project-root "/home/ahonnecke/src/")

(setq
   pipenv-projectile-after-switch-function
   #'pipenv-projectile-after-switch-extended)

(use-package pipenv
  :hook (python-mode . pipenv-mode)
  :init
  (setq
   pipenv-projectile-after-switch-function
   #'pipenv-projectile-after-switch-extended))

(add-hook 'python-mode-hook 'blacken-mode)

(defun find-file-at-point-with-line (&optional filename)
  "Opens file at point and moves point to line specified next to file name."
  (interactive)
  (let* ((filename (or filename (if current-prefix-arg (ffap-prompter) (ffap-guesser))))
         (line-number
          (and (or (looking-at ".* line \\(\[0-9\]+\\)")
                   (looking-at "[^:]*:\\(\[0-9\]+\\)"))
               (string-to-number (match-string-no-properties 1))))
         (column-number
          (or
           (and (looking-at "[^:]*:\[0-9\]+:\\(\[0-9\]+\\)")
                (string-to-number (match-string-no-properties 1)))
           (let 'column-number 0))))

    (let ((real (car (s-split "\\:" filename))))
          (message "%s --> %s:%s" real line-number column-number)
    (cond ((ffap-url-p real)
           (let (current-prefix-arg)
             (funcall ffap-url-fetcher real)))
          ((and line-number
                (file-exists-p real))
           (progn (find-file-other-window real)
                  ;; goto-line is for interactive use
                  (goto-char (point-min))
                  (forward-line (1- line-number))
                  (forward-char column-number)))
          ((and ffap-pass-wildcards-to-dired
                ffap-dired-wildcards
                (string-match ffap-dired-wildcards real))
           (funcall ffap-directory-finder real))
          ((and ffap-dired-wildcards
                (string-match ffap-dired-wildcards real)
                find-file-wildcards
                ;; Check if it's find-file that supports wildcards arg
                (memq ffap-file-finder '(find-file find-alternate-file)))
           (funcall ffap-file-finder (expand-file-name real) t))
          ((or (not ffap-newfile-prompt)
               (file-exists-p real)
               (y-or-n-p "File does not exist, create buffer? "))
           (funcall ffap-file-finder
                    ;; expand-file-name fixes "~/~/.emacs" bug sent by CHUCKR.
                    (expand-file-name real)))
          ;; User does not want to find a non-existent file:
          ((signal 'file-error (list "Opening file buffer"
                                     "no such file or directory"
                                     real))))
      )
))

(define-key magit-process-mode-map  (kbd "<return>") 'find-file-at-point-with-line)
