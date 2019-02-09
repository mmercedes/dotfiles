;;; scala-mode-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (scala-mode scala-mode:goto-start-of-code scala-mode:set-scala-syntax-mode)
;;;;;;  "scala-mode" "../../../../.emacs.d/elpa/scala-mode-20170802.1132/scala-mode.el"
;;;;;;  "8685b8fadf5f3bc6c94f078230dda468")
;;; Generated autoloads from ../../../../.emacs.d/elpa/scala-mode-20170802.1132/scala-mode.el

(autoload 'scala-mode:set-scala-syntax-mode "scala-mode" "\
Sets the syntax-table and other related variables for the current buffer to those of scala-mode. Can be used to make some other major mode (such as sbt-mode) use scala syntax-table.

\(fn)" nil nil)

(autoload 'scala-mode:goto-start-of-code "scala-mode" "\
Go to the start of the real code in the file: object, class or trait.

\(fn)" t nil)

(autoload 'scala-mode "scala-mode" "\
Major mode for editing scala code.

When started, runs `scala-mode-hook'.

\\{scala-mode-map}

\(fn)" t nil)

(add-to-list 'auto-mode-alist '("\\.\\(scala\\|sbt\\)\\'" . scala-mode))

(modify-coding-system-alist 'file "\\.\\(scala\\|sbt\\)\\'" 'utf-8)

;;;***

;;;### (autoloads nil nil ("../../../../.emacs.d/elpa/scala-mode-20170802.1132/ob-scala.el"
;;;;;;  "../../../../.emacs.d/elpa/scala-mode-20170802.1132/scala-mode-fontlock.el"
;;;;;;  "../../../../.emacs.d/elpa/scala-mode-20170802.1132/scala-mode-imenu.el"
;;;;;;  "../../../../.emacs.d/elpa/scala-mode-20170802.1132/scala-mode-indent.el"
;;;;;;  "../../../../.emacs.d/elpa/scala-mode-20170802.1132/scala-mode-lib.el"
;;;;;;  "../../../../.emacs.d/elpa/scala-mode-20170802.1132/scala-mode-map.el"
;;;;;;  "../../../../.emacs.d/elpa/scala-mode-20170802.1132/scala-mode-paragraph.el"
;;;;;;  "../../../../.emacs.d/elpa/scala-mode-20170802.1132/scala-mode-pkg.el"
;;;;;;  "../../../../.emacs.d/elpa/scala-mode-20170802.1132/scala-mode-prettify-symbols.el"
;;;;;;  "../../../../.emacs.d/elpa/scala-mode-20170802.1132/scala-mode-syntax.el"
;;;;;;  "../../../../.emacs.d/elpa/scala-mode-20170802.1132/scala-mode.el")
;;;;;;  (23647 21499 435994 311000))

;;;***

(provide 'scala-mode-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; scala-mode-autoloads.el ends here
