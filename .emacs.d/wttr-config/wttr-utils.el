;; -*- coding: utf-8 -*-

;; `load-path' is a list of directories where Emacs Lisp libraries
;; (`.el' and `.elc' files) are installed.
;;
;; `exec-path' is different: it is a list of directories where
;; executable programs are installed.
;;
;; Shouldn't be `exec-path' and `PATH' achieve the same goal under
;; Emacs?
;;
;; No. `exec-path' is used by Emacs to search for programs it runs
;; directly.  But `M-x grep' does not run `grep.exe' directly; it runs
;; the shell passing it a command that invokes `grep'. So it's the
;; shell that needs to find `grep.exe', and it uses PATH, of course,
;; not `exec-path'.
;;
;; So the right thing to do when you install a new program, in order
;; for Emacs to find it, is *both* to update `exec-path' *and* update
;; `PATH'. This is because some Emacs features invoke programs
;; directly, while others do that through the shell or some other
;; intermediary programs.
(defun wttr/add-to-exec-path (path)
  (setq exec-path
        (cons (expand-file-name path)
              exec-path))
  (setenv "PATH" (concat (expand-file-name path)
                         path-separator
                         (getenv "PATH"))))



(provide 'wttr-utils)