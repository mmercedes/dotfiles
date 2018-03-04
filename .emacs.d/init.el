(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("21763c0648b03fc9cdcc35d91f51077a6cd6a063a6bfd532e0dfab68b948484a" "7e6b4f2dc84ed26d2002505f47de8fb138b130456b567cb48ae365f9774c2141" "84d2f9eeb3f82d619ca4bfffe5f157282f4779732f48a5ac1484d94d5ff5b279" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; make and save backups of files to directory
(setq backup-before-writing t)
(setq backup-by-copying-when-linked t)
(setq make-backup-files t)
(setq backup-directory-alist (quote ((".*" . "~/.emacs.d/backups/"))))

(put 'erase-buffer 'disabled nil)
(setq-default yank-excluded-properties t)
(setq c-indent-level 4)
(setq ctl-arrow t)
(setq default-case-fold-search t)
(setq wrap-long-lines t)
(setq require-final-newline t)
(setq-default indent-tabs-mode nil)
(setq c-basic-offset 4)

(global-set-key "\ek" 'kill-to-start-of-line)
(defun kill-to-start-of-line ()
  "Kill from dot to start of line"
  (interactive)
  (save-excursion
    (set-mark-command nil)
    (beginning-of-line)
    (kill-region (point) (mark))))

(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; load previous buffers
(setq-default desktop-load-locked-desktop t)
(setq-default desktop-save-mode t)
(setq-default desktop-restore-forces-onscreen nil)
(desktop-read)

;; monokai theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'monokai t)

;; show line numbers in left margin
(global-linum-mode 1)
(setq linum-format "%3d \u2502 ")

;; hide menubar
(menu-bar-mode -1)

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

;; keybinds
(global-set-key [(control j)] 'goto-line)

;; MELPA
(require 'package) ;; You might already have this line
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives
             '("melpa stable" . "https://stable.melpa.org/packages/") t)
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))

(package-initialize) ;;

;; PHP mode
(require 'php-mode)

;; Web mode
(require 'web-mode)

;; set web mode for .mustach files
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))

;; map C-t to switching to terminal, creating one if none exists
(defun switch-to-term ()
  "go to console buffer if it exists, otherwise create"
  (interactive)
  (let ((buffer-name "*ansi-term*"))
    (if (get-buffer buffer-name)
        (switch-to-buffer buffer-name)
      (call-interactively 'ansi-term))))

(global-set-key [(control t)] 'switch-to-term)

;; Smart Mode Line
(sml/setup)
(add-to-list 'sml/replacer-regexp-list '("^~/development/" ":DEV:") t)

;; turn on flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)
;; dont syntax check this file :)
(setq-default flycheck-disabled-checkers '(emacs-lisp emacs-lisp-checkdoc php-phpcs php-phpmd))
(eval-after-load "flycheck"
  '(add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode))
(eval-after-load "flycheck"
  '(progn (set-face-attribute 'flycheck-error nil :foreground "white" :background "red")))
(eval-after-load "flycheck"
  '(progn (set-face-attribute 'flycheck-warning nil :foreground "black" :background "yellow")))
