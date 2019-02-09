;;; smart-mode-line-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (sml/setup) "smart-mode-line" "../../../../.emacs.d/elpa/smart-mode-line-20180926.1036/smart-mode-line.el"
;;;;;;  "6bb16201af60d07659dc717f31ac9d53")
;;; Generated autoloads from ../../../../.emacs.d/elpa/smart-mode-line-20180926.1036/smart-mode-line.el

(when load-file-name (let ((dir (file-name-as-directory (file-name-directory load-file-name)))) (add-to-list 'custom-theme-load-path dir) (when (file-directory-p (file-name-as-directory (concat dir "themes"))) (add-to-list 'custom-theme-load-path (file-name-as-directory (concat dir "themes"))))))

(autoload 'sml/setup "smart-mode-line" "\
Setup the mode-line to be smart and sexy.

ARG is ignored. Just call this function in your init file, and
the mode-line will be setup.

\(fn &optional ARG)" t nil)

(defalias 'smart-mode-line-enable #'sml/setup)

;;;***

;;;### (autoloads nil "smart-mode-line-dark-theme" "../../../../.emacs.d/elpa/smart-mode-line-20180926.1036/smart-mode-line-dark-theme.el"
;;;;;;  "075110d335eaacdc87ab694e90bffa45")
;;; Generated autoloads from ../../../../.emacs.d/elpa/smart-mode-line-20180926.1036/smart-mode-line-dark-theme.el

(when load-file-name (add-to-list 'custom-theme-load-path (file-name-as-directory (file-name-directory load-file-name))))

;;;***

;;;### (autoloads nil "smart-mode-line-light-theme" "../../../../.emacs.d/elpa/smart-mode-line-20180926.1036/smart-mode-line-light-theme.el"
;;;;;;  "00397cf05d85e6f5e0c8f29d48cf2253")
;;; Generated autoloads from ../../../../.emacs.d/elpa/smart-mode-line-20180926.1036/smart-mode-line-light-theme.el

(when load-file-name (add-to-list 'custom-theme-load-path (file-name-as-directory (file-name-directory load-file-name))))

;;;***

;;;### (autoloads nil "smart-mode-line-respectful-theme" "../../../../.emacs.d/elpa/smart-mode-line-20180926.1036/smart-mode-line-respectful-theme.el"
;;;;;;  "85bd551fa8d4473141c6bef29a146ab6")
;;; Generated autoloads from ../../../../.emacs.d/elpa/smart-mode-line-20180926.1036/smart-mode-line-respectful-theme.el

(when load-file-name (add-to-list 'custom-theme-load-path (file-name-as-directory (file-name-directory load-file-name))))

;;;***

;;;### (autoloads nil nil ("../../../../.emacs.d/elpa/smart-mode-line-20180926.1036/smart-mode-line-dark-theme.el"
;;;;;;  "../../../../.emacs.d/elpa/smart-mode-line-20180926.1036/smart-mode-line-light-theme.el"
;;;;;;  "../../../../.emacs.d/elpa/smart-mode-line-20180926.1036/smart-mode-line-pkg.el"
;;;;;;  "../../../../.emacs.d/elpa/smart-mode-line-20180926.1036/smart-mode-line-respectful-theme.el"
;;;;;;  "../../../../.emacs.d/elpa/smart-mode-line-20180926.1036/smart-mode-line.el")
;;;;;;  (23647 21500 74549 906000))

;;;***

(provide 'smart-mode-line-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; smart-mode-line-autoloads.el ends here
