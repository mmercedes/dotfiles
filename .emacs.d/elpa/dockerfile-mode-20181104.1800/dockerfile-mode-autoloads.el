;;; dockerfile-mode-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (dockerfile-mode dockerfile-build-no-cache-buffer
;;;;;;  dockerfile-build-buffer) "dockerfile-mode" "../../../../.emacs.d/elpa/dockerfile-mode-20181104.1800/dockerfile-mode.el"
;;;;;;  "243de13f908733a5e9b1d5272b9102d5")
;;; Generated autoloads from ../../../../.emacs.d/elpa/dockerfile-mode-20181104.1800/dockerfile-mode.el

(autoload 'dockerfile-build-buffer "dockerfile-mode" "\
Build an image called IMAGE-NAME based upon the buffer.
If prefix arg NO-CACHE is set, don't cache the image.

\(fn IMAGE-NAME &optional NO-CACHE)" t nil)

(autoload 'dockerfile-build-no-cache-buffer "dockerfile-mode" "\
Build an image called IMAGE-NAME based upon the buffer without cache.

\(fn IMAGE-NAME)" t nil)

(autoload 'dockerfile-mode "dockerfile-mode" "\
A major mode to edit Dockerfiles.
\\{dockerfile-mode-map}

\(fn)" t nil)

(add-to-list 'auto-mode-alist '("Dockerfile\\(?:\\..*\\)?\\'" . dockerfile-mode))

;;;***

;;;### (autoloads nil nil ("../../../../.emacs.d/elpa/dockerfile-mode-20181104.1800/dockerfile-mode-pkg.el"
;;;;;;  "../../../../.emacs.d/elpa/dockerfile-mode-20181104.1800/dockerfile-mode.el")
;;;;;;  (23647 21492 30994 591000))

;;;***

(provide 'dockerfile-mode-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; dockerfile-mode-autoloads.el ends here
