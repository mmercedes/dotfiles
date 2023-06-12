;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Backups                                           ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; make and save backups of files to directory
(setq backup-before-writing t)
(setq backup-by-copying-when-linked t)
(setq make-backup-files t)
(setq backup-directory-alist (quote ((".*" . "~/.emacs.d/backups/"))))

;; load previous buffers
(setq-default desktop-load-locked-desktop t)
(setq-default desktop-save-mode t)
(setq-default desktop-restore-forces-onscreen nil)
(desktop-read)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Packages                                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives
             '("melpa stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives
	     '("gnu" . "http://elpa.gnu.org/packages/") t)

(setq package-list
      '(cl-lib
	company
        dap-mode
        dash
        dockerfile-mode
        epl
        flycheck
        flycheck-color-mode-line
        go-mode
        google-c-style
        groovy-mode
        gruvbox-theme
        hcl-mode
        helm
        helm-lsp
        helm-ag
        jinja2-mode
        json-mode
        json-reformat
        json-snatcher
        jsonnet-mode
        let-alist
        lsp-java
        lsp-mode
        lsp-treemacs
        lsp-ui
        markdown-mode
        pkg-info
        powerline
        protobuf-mode
        python-docstring
        rich-minority
        s
        scala-mode
        seq
        smart-mode-line
        terraform-mode
        typescript-mode
	use-package
        web-mode
        yaml-mode))

; activate all the packages
(package-initialize)

; fetch the list of packages available 
(unless package-archive-contents
  (package-refresh-contents))

; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Modes                                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  
(helm-mode 1)
(set-face-attribute 'helm-selection nil 
                    :background "#B16286"
                    :foreground "#FFFFFF")

(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.java\\'" . java-mode))
(add-to-list 'auto-mode-alist '("\\.toml\\'" . conf-mode))
(add-to-list 'auto-mode-alist '("\\.bazel\\'" . bazel-mode))
(add-to-list 'auto-mode-alist '("\\.plist\\'" . xml-mode))
(add-to-list 'auto-mode-alist '("\\.proto\\'" . protobuf-mode))

(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; turn on company ("complete anything") mode for all files
(add-hook 'after-init-hook 'global-company-mode)

;; turn on flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)

;; dont syntax check this file
(setq-default flycheck-disabled-checkers '(emacs-lisp emacs-lisp-checkdoc))

(eval-after-load "flycheck"
  '(add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode))
(eval-after-load "flycheck"
  '(progn (set-face-attribute 'flycheck-error nil :foreground "white" :background "red")))
(eval-after-load "flycheck"
  '(progn (set-face-attribute 'flycheck-warning nil :foreground "black" :background "yellow")))
(eval-after-load "flycheck"
  '(setq flycheck-python-pylint-executable "python3"))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; LSP + JAVA  ಠ_ಠ                                   ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq max-lisp-eval-depth 10000)
(use-package lsp-mode
  :hook ((scala-mode . lsp)
	 (lsp-mode . lsp-lens-mode)
	 (lsp-mode . lsp-enable-which-key-integration))
  :config
  (setq gc-cons-threshold (* 100 1024 1024)
	read-process-output-max (* 1024 1024) ;; 1mb
	lsp-idle-delay 0.200
	lsp-log-io nil
	lsp-completion-provider :capf
	lsp-prefer-flymake nil
        lsp-keep-workspace-alive nil))

(use-package lsp-ui
  :commands (lsp-ui-mode)
  :config
  (setq lsp-ui-sideline-enable nil
        lsp-ui-doc-delay 1.0
        lsp-ui-doc-include-signature t
        lsp-ui-flycheck-enable t
        lsp-ui-peek-always-show t
        lsp-eldoc-enable-hover t
        lsp-signature-auto-activate t
        lsp-signature-doc-lines 1
        lsp-signature-function 'lsp-signature-posframe))

(use-package dap-mode
  :after lsp-mode
  :config
  (dap-register-debug-template "Spotify"
                               (list :type "java"
                                     :request "launch"
                                     :env '(("SPOTIFY_DOMAIN" . "gue1.spotify.net") ("SPOTIFY_POD" . "gue1"))))
  (dap-auto-configure-mode)
  (setq dap-auto-configure-features '(sessions locals controls tooltip))
  :bind (:map lsp-mode-map
         ("<f5>" . dap-debug)
         ("M-<f5>" . dap-hydra))
  :hook ((dap-mode . dap-ui-mode)))

(use-package helm-lsp
  :commands helm-lsp-workspace-symbol
  :config (helm-mode))

(use-package lsp-treemacs
  :after (lsp-mode treemacs)
  :config
  (lsp-treemacs-sync-mode 1))

(setenv "JAVA_HOME" "/Users/mmercedes/.jenv/versions/17")

(use-package lsp-java
  :hook (java-mode . lsp-deferred)
  :bind (("C-x d" . lsp-goto-type-definition))  
  :config
  (setq
   ;; lsp-java-jdt-download-url "https://www.eclipse.org/downloads/download.php?file=/jdtls/snapshots/jdt-language-server-latest.tar.gz"
   lsp-java-completion-max-results 10
   lsp-java-configuration-runtimes '[(:name "JavaSE-17" :path "/Users/mmercedes/.jenv/versions/17" :default t)]
   lsp-java-vmargs '( "-noverify"
                      "-Xmx2048m"
                      "-XX:+UseG1GC"
                      "-XX:+UseStringDeduplication")
   lsp-java-java-path "/Users/mmercedes/.jenv/versions/17/bin/java")

  (lsp-register-custom-settings `(("java.inlayHints.parameterNames.enabled" "literals" "literals"))))

;; good enough indentation before apheleia takes over
(use-package google-c-style
  :hook (java-mode . google-set-c-style)
  :hook (java-mode . google-make-newline-indent))

(defun my-configure-java ()
  (setq c-basic-offset 2)
  (setq tab-width 2)
  (setq-default indent-tabs-mode nil))

(add-hook 'java-mode-hook 'my-configure-java)  

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Helm                                              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package helm
  :config
  (progn
    (require 'helm-for-files)
    (setq
     helm-canditate-number-limit 100
     helm-display-function #'pop-to-buffer
     helm-idle-delay 0.0
     helm-input-idle-delay 0.01
     helm-yas-display-key-on-candidate t
     helm-quick-update t
     helm-M-x-requires-pattern nil
     helm-ff-skip-boring-files t))
  (helm-mode 1)
  :bind (("M-x" . helm-M-x)
         ("M-y" . helm-show-kill-ring)
         ("C-s" . helm-occur)
         ("C-x C-f" . helm-find-files)
         ("C-x C-d" . helm-browse-project)
         ("C-x b" . helm-mini)))

(use-package helm-ag
  :bind (("M-r" . helm-do-ag-project-root))
  :custom
  (helm-ag-use-agignore t))
     
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; UI                                                ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; hide menubar
(menu-bar-mode -1)

;; show line numbers in left margin
(global-linum-mode 1)
(setq linum-format "%3d \u2502 ")

;; Smart Mode Line
(sml/setup)
(add-to-list 'sml/replacer-regexp-list '("^~/development/" ":DEV:") t)

(load-theme 'gruvbox-dark-medium t)
(load-theme 'smart-mode-line-dark t)

;; respond to mouse
(unless window-system
  (require 'mouse)
  (xterm-mouse-mode t)
  (global-set-key [mouse-4] (lambda () (interactive) (scroll-down 1)))
  (global-set-key [mouse-5] (lambda () (interactive) (scroll-up 1)))
  (defun track-mouse (e))
  (setq mouse-sel-mode t)
)

;; set yes/no prompts to y/n
(fset 'yes-or-no-p 'y-or-n-p)

(put 'erase-buffer 'disabled nil)
(setq-default yank-excluded-properties t)
(setq c-indent-level 4)
(setq ctl-arrow t)
(setq default-case-fold-search t)
(setq wrap-long-lines t)
(setq require-final-newline t)
(setq-default indent-tabs-mode nil)
(setq c-basic-offset 4)

;; override golangs default indents to a sane amount
(add-hook 'go-mode-hook
          (lambda ()
            (setq indent-tabs-mode 1)
            (setq tab-width 4)))

;; override typescript indent
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq indent-line-function 'insert-tab)

;; set default font
(add-to-list 'default-frame-alist '(font . "Roboto Mono" ))
(set-face-attribute 'default t :font "Roboto Mono" )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Keybinds                                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(global-set-key [(control j)] 'goto-line)

(global-set-key (kbd "C-x C-r") 'query-replace-regexp)

;; map C-t to switching to terminal, creating one if none exists
(defun switch-to-term ()
  "go to console buffer if it exists, otherwise create"
  (interactive)
  (let ((buffer-name "*ansi-term*"))
    (if (get-buffer buffer-name)
        (switch-to-buffer buffer-name)
      (call-interactively 'ansi-term))))

(global-set-key "\ek" 'kill-to-start-of-line)
(defun kill-to-start-of-line ()
  "Kill from dot to start of line"
  (interactive)
  (save-excursion
    (set-mark-command nil)
    (beginning-of-line)
    (kill-region (point) (mark))))

(global-set-key [(control t)] 'switch-to-term)

;; start server mode
(server-start)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" default))
 '(package-selected-packages
   '(yaml-mode web-mode typescript-mode terraform-mode smart-mode-line scala-mode rich-minority python-docstring protobuf-mode powerline markdown-mode jsonnet-mode json-reformat json-mode jinja2-mode helm hcl-mode gruvbox-theme groovy-mode go-mode flycheck-color-mode-line flycheck epl dockerfile-mode dash company)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
