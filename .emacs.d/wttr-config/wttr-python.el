;; -*- coding: utf-8 -*-

(when wttr/os:win32p
  (wttr/prepend-to-exec-path "c:/Python27"))

(setq-default py-indent-offset 4)
(wttr/plugin:prepend-to-load-path "python-enhance")
(add-to-list 'auto-mode-alist '("\\.py$\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))
(autoload 'python-mode "python-mode" "Python Mode." t)
(setq python-mode-hook nil)
(add-to-list 'python-mode-hook
             (lambda () (require 'pycomplete)))

(provide 'wttr-python)
