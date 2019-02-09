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
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))

(setq package-list
      '(dash
        dockerfile-mode
        epl
        flycheck
        flycheck-color-mode-line
        go-mode
        groovy-mode
        hcl-mode
        json-mode
        json-reformat
        json-snatcher
        let-alist
        php-mode
        pkg-info
        powerline
        python-docstring
        rich-minority
        s
        scala-mode
        seq
        smart-mode-line
        terraform-mode
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

(require 'php-mode)

(require 'web-mode)

;; set web mode for .mustach files
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))

;; set conf mode for .toml files
(add-to-list 'auto-mode-alist '("\\.toml\\'" . conf-mode))

(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; turn on flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)

;; dont syntax check this file
(setq-default flycheck-disabled-checkers '(emacs-lisp emacs-lisp-checkdoc php-phpcs php-phpmd))

(eval-after-load "flycheck"
  '(add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode))
(eval-after-load "flycheck"
  '(progn (set-face-attribute 'flycheck-error nil :foreground "white" :background "red")))
(eval-after-load "flycheck"
  '(progn (set-face-attribute 'flycheck-warning nil :foreground "black" :background "yellow")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; UI                                                ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; hide menubar
(menu-bar-mode -1)

;; show line numbers in left margin
(global-linum-mode 1)
(setq linum-format "%3d \u2502 ")

;; monokai theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'monokai t)

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

;; Smart Mode Line
(sml/setup)
(add-to-list 'sml/replacer-regexp-list '("^~/development/" ":DEV:") t)

;; override golangs default indents to a sane amount
(add-hook 'go-mode-hook
          (lambda ()
            (setq indent-tabs-mode 1)
            (setq tab-width 4)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Keybinds                                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(global-set-key [(control j)] 'goto-line)

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
 '(custom-safe-themes (quote ("3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
