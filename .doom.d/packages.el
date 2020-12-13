;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; To install a package with Doom you must declare them here and run 'doom sync'
;; on the command line, then restart Emacs for the changes to take effect -- or
;; use 'M-x doom/reload'.


;; To install SOME-PACKAGE from MELPA, ELPA or emacsmirror:
;(package! some-package)

;; To install a package directly from a remote git repo, you must specify a
;; `:recipe'. You'll find documentation on what `:recipe' accepts here:
;; https://github.com/raxod502/straight.el#the-recipe-format
;(package! another-package
;  :recipe (:host github :repo "username/repo"))

;; If the package you are trying to install does not contain a PACKAGENAME.el
;; file, or is located in a subdirectory of the repo, you'll need to specify
;; `:files' in the `:recipe':
;(package! this-package
;  :recipe (:host github :repo "username/repo"
;           :files ("some-file.el" "src/lisp/*.el")))

;; If you'd like to disable a package included with Doom, you can do so here
;; with the `:disable' property:
;(package! builtin-package :disable t)

;; You can override the recipe of a built in package without having to specify
;; all the properties for `:recipe'. These will inherit the rest of its recipe
;; from Doom or MELPA/ELPA/Emacsmirror:
;(package! builtin-package :recipe (:nonrecursive t))
;(package! builtin-package-2 :recipe (:repo "myfork/package"))

;; Specify a `:branch' to install a package from a particular branch or tag.
;; This is required for some packages whose default branch isn't 'master' (which
;; our package manager can't deal with; see raxod502/straight.el#279)
;(package! builtin-package :recipe (:branch "develop"))

;; Use `:pin' to specify a particular commit to install.
;(package! builtin-package :pin "1a2b3c4d5e")


;; Doom's packages are pinned to a specific commit and updated from release to
;; release. The `unpin!' macro allows you to unpin single packages...
;(unpin! pinned-package)
;; ...or multiple packages
;(unpin! pinned-package another-pinned-package)
;; ...Or *all* packages (NOT RECOMMENDED; will likely break things)
;(unpin! t)


(defun load-directory (dir)
  (let ((load-it (lambda (f)
                   (load-file (concat (file-name-as-directory dir) f)))
                 ))
    (mapc load-it (directory-files dir nil "\\.el$"))))

(package! auto-highlight-symbol)
(package! ace-window)
(package! ace-jump-mode)
(package! auto-highlight-symbol)
(package! avy)
(package! key-chord)
(package! blacken)
(package! browse-at-remote)
;; (package! ibuffer)
;; (package! ibuffer-vc)
;; (package! docker)
(package! dockerfile-mode)
;; (package! groovy-mode)
;; (package! ccls)
;; (package! modern-cpp-font-lock)
;; (package! go-mode)
;; (package! evil-nerd-commenter)
;; (package! company)
;; (package! company-lsp)
;; (package! company-tabnine)
;; (package! company-box)
(package! crux)
;; (package! dashboard)
;; (package! page-break-lines)
(package! deadgrep)
;; (package! debbugs)
;; (package! dired)
;; (package! disk-usage)
;; (package! discover-my-major)
;; (package! dumb-jump)
;; (package! eaf)
;; (package! iedit)
;; (package! awesome-pair)
;; (package! conf-mode)
;; (package! delete-block)
;; (package! ein)
;; (package! epaint)
;; (package! erc)
;; (package! erc-hl-nicks)
;; (package! erc-image)
;; (package! ess)
;; (package! eww)
(package! expand-region)
(package! ffap)
(package! flycheck)
;; (package! flycheck-grammarly )
;; (package! flycheck-posframe)
;; (package! flycheck-pos-tip)
;; (package! all-the-icons)
(package! forge)
(package! pipenv)
(package! lsp-docker)
;; (package! format-all)
;; (package! "fzf")
;; (package! tetris)
;; (package! speed-type)
;; (package! 2048-game)
(package! git-timemachine)
;; (package! sudo-edit)
;; (package! recentf)
;; (package! google-this)
;; (package! haskell-mode)
;; (package! header2)
(package! helm-projectile)
(package! helm-rg)
;; (package! py-isort)
;; (package! highlight-indent-guides)
(package! ini-mode)
;; (package! pyim)
;; (package! posframe)
;; (package! pyim-basedict)
;; (package! lsp-java)
;; (package! request)
;; (package! tex)
;; (package! org-latex-instant-preview)
;; (package! leetcode)
;; (package! graphql)
;; (package! aio)
;; (package! lsp-mode)
;; (package! lsp-ui)
;; (package! dap-mode)
(package! magit)
;; (package! mu4e)
;; (package! mu4e-alert)
;; (package! mu4e-overview)
;; (package! org)
;; (package! toc-org)
;; (package! htmlize)
;; (package! ox-gfm)
;; (package! plantuml-mode)
;; (package! auto-package-update)
;; (package! diminish)
;; (package! smartparens)
;; (package! pdf-tools-install)
;; (package! popup-kill-ring)
;; (package! projectile)
;; (package! py-isort)
;; (package! python-mode)
;; (package! lsp-python-ms)
;; (package! quickrun)
(package! rg)
;; (package! ivy)
;; (package! amx)
;; (package! swiper)
;; (package! color-rg)
;; (package! find-file-in-project)
;; (package! snails)
;; (package! aweshell)
;; (package! shell-here)
;; (package! multi-term)
;; (package! term-keys)
;; (package! string-inflection)
;; (package! doom-themes)
;; (package! doom-modeline)
(package! tramp)
;; (package! treemacs)
;; (package! treemacs-magit)
;; (package! treemacs-projectile)
(package! undo-tree)
(package! web-mode)
;; (package! js2-mode)
;; (package! typescript-mode)
;; (package! emmet-mode)
;; (package! instant-rename-tag)
(package! json-mode)
;; (package! which-key)
;; (package! winner)
;; (package! yasnippet)
;; (package! yasnippet-snippets)
;; (package! zone)
