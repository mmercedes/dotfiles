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
        solarized-theme
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
;;(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
;;(load-theme 'monokai t)

(load-theme 'solarized-dark t)

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
 '(ansi-color-names-vector ["#073642" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#657b83"])
 '(compilation-message-face (quote default))
 '(cua-global-mark-cursor-color "#2aa198")
 '(cua-normal-cursor-color "#839496")
 '(cua-overwrite-cursor-color "#b58900")
 '(cua-read-only-cursor-color "#859900")
 '(custom-safe-themes (quote ("8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default)))
 '(fci-rule-color "#073642")
 '(highlight-changes-colors (quote ("#d33682" "#6c71c4")))
 '(highlight-symbol-colors (--map (solarized-color-blend it "#002b36" 0.25) (quote ("#b58900" "#2aa198" "#dc322f" "#6c71c4" "#859900" "#cb4b16" "#268bd2"))))
 '(highlight-symbol-foreground-color "#93a1a1")
 '(highlight-tail-colors (quote (("#073642" . 0) ("#546E00" . 20) ("#00736F" . 30) ("#00629D" . 50) ("#7B6000" . 60) ("#8B2C02" . 70) ("`#93115C" . 85) ("#073642" . 100))))
 '(hl-bg-colors (quote ("#7B6000" "#8B2C02" "#990A1B" "#93115C" "#3F4D91" "#00629D" "#00736F" "#546E00")))
 '(hl-fg-colors (quote ("#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36")))
 '(hl-paren-colors (quote ("#2aa198" "#b58900" "#268bd2" "#6c71c4" "#859900")))
 '(magit-diff-use-overlays nil)
 '(nrepl-message-colors (quote ("#dc322f" "#cb4b16" "#b58900" "#546E00" "#B4C342" "#00629D" "#2aa198" "#d33682" "#6c71c4")))
 '(pos-tip-background-color "#073642")
 '(pos-tip-foreground-color "#93a1a1")
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#073642" 0.2))
 '(term-default-bg-color "#002b36")
 '(term-default-fg-color "#839496")
 '(vc-annotate-background nil)
 '(vc-annotate-background-mode nil)
 '(vc-annotate-color-map (quote ((20 . "#dc322f") (40 . "#e47200") (60 . "#e4ab00") (80 . "#b58900") (100 . "#e4e400") (120 . "#e4e400") (140 . "#e4e400") (160 . "#e4e400") (180 . "#859900") (200 . "#98e44c") (220 . "#72e472") (240 . "#4ce498") (260 . "#26e4be") (280 . "#2aa198") (300 . "#00e4e4") (320 . "#00e4e4") (340 . "#00e4e4") (360 . "#268bd2"))))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list (quote (unspecified "#002b36" "#073642" "#990A1B" "#dc322f" "#546E00" "#859900" "#7B6000" "#b58900" "#00629D" "#268bd2" "#93115C" "#d33682" "#00736F" "#2aa198" "#839496" "#657b83")))
 '(xterm-color-names ["#073642" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#eee8d5"])
 '(xterm-color-names-bright ["#002b36" "#cb4b16" "#586e75" "#657b83" "#839496" "#6c71c4" "#93a1a1" "#fdf6e3"]))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
