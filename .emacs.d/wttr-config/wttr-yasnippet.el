;; -*- coding: utf-8 -*-

;; yasnippet
(wttr/plugin:prepend-to-load-path "yasnippet-0.6.1c")
(require 'yasnippet)
(yas/initialize)
(yas/load-directory (wttr/plugin:expand-file-name "yasnippet-0.6.1c/snippets"))


(provide 'wttr-yasnippet)
