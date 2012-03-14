;; -*- coding: utf-8 -*-

;; === grep mode ===
;; we do not need to setup the grep command, use the correct exec-path
;; and "PATH" env is enough
(require 'grep)
(grep-apply-setting
 'grep-find-use-xargs 'exec)

(when wttr/os:win32p
  (defadvice grep-expand-template (around grep-expand-template-w32-around (template &optional regexp files dir excl))
    "A patch for the windows system, as the [find . -iname \"balabala\" -exec grep \"grep-bala\" {} ;] will
result as a seperate windows process [grep grep-balaba file-name-from-find].
When grep-bala contains *, this will lead to very wierd result as the paramter is not quoted in new process.
So I patch it."
    (if (string-match-p "find.*grep" template)
        (let ((regexp (format "\"%s\"" regexp)))
          ad-do-it)))
  (ad-activate 'grep-expand-template))

;(grep-apply-setting
; 'grep-find-command
; '("E:/Tools/Emacs/bin/find.exe . -type f -exec E:/Tools/Emacs/bin/grep.exe -nH -ie  {} NUL \";\"" . 80 ) )
;(grep-apply-setting
; 'grep-command
; "E:/Tools/Emacs/bin/grep.exe -nH -ie ")
;(grep-apply-setting
; 'grep-find-template
; "E:/Tools/Emacs/bin/find.exe . <X> -type f <F> -exec E:/Tools/Emacs/bin/grep.exe <C> -nH -ie <R> {} NUL \";\"" )
;(setq grep-program "grep.exe")
;(setq find-program "find.exe")

;; === hippie mode ===
(setq hippie-expand-try-functions-list
      '(try-expand-dabbrev
	try-expand-dabbrev-visible
	try-expand-dabbrev-all-buffers
	try-expand-dabbrev-from-kill
	try-complete-file-name-partially
	try-complete-file-name
	try-expand-all-abbrevs
	try-expand-list
	try-expand-line
	try-complete-lisp-symbol-partially
	try-complete-lisp-symbol))

;; quick for use ibuffer
(autoload 'ibuffer "ibuffer" "ibuffer mode" t)
(global-set-key (kbd "C-x C-b") 'ibuffer)

;;js2 mode
(wttr/prepend-to-load-path "~/.emacs.d/plugins/js2-mode-20090723/")
(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;; dos mode
(wttr/prepend-to-load-path "~/.emacs.d/plugins/dos-2.16/")
(autoload 'dos-mode "dos" "Edit Dos scripts." t)
(add-to-list 'auto-mode-alist '("\\.bat$" . dos-mode))
(add-to-list 'auto-mode-alist '("\\.cmd$" . dos-mode))

;; occur specific setting
(setq list-matching-lines-default-context-lines 2)

;; hilight-symbol
(wttr/prepend-to-load-path "~/.emacs.d/plugins/highlight-symbol-1.1/")
(autoload 'highlight-symbol-at-point "highlight-symbol" nil t)
(global-set-key [f3] 'highlight-symbol-at-point)
;(global-set-key [(control f3)] 'highlight-symbol-at-point)
;(global-set-key [(shift f3)] 'highlight-symbol-prev)
;(global-set-key [(meta f3)] 'highlight-symbol-prev)


;; nXML
(setq nxml-slash-auto-complete-flag t)
(setq nxml-child-indent 2)
(setq nxml-attribute-indent 4)


;browser kill ring mode
(wttr/prepend-to-load-path "~/.emacs.d/plugins/browser-king-ring-1.3a/")
(require 'browse-kill-ring)
(browse-kill-ring-default-keybindings)

;; use gsl-mode, for gomez, but there is no use now
;(wttr/prepend-to-load-path "~/.emacs.d/plugins/gsl-mode/")
;(add-to-list 'auto-mode-alist '("\\.gsl$" . gsl-mode))
;(autoload 'gsl-mode "gsl-mode" "my gsl mode" t)

;; use ace-jump-mode
(wttr/prepend-to-load-path "~/.emacs.d/plugins/ace-jump-mode/")
(autoload
  'ace-jump-mode
  "ace-jump-mode"
  "Emacs quick move minor mode"
  t)
;; I also use SPC in viper mode to direct start this mode
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

;; window move mode
(when (boundp 'windmove-default-keybindings)
  (windmove-default-keybindings 'meta))
(global-set-key (kbd "M-j") 'windmove-down)
(global-set-key (kbd "M-k") 'windmove-up)
(global-set-key (kbd "M-h") 'windmove-left)
(global-set-key (kbd "M-l") 'windmove-right)

;; gtags
(wttr/prepend-to-load-path "~/.emacs.d/plugins/gtags")
(autoload 'gtags-mode "gtags" "" t)

;; cscope

(wttr/prepend-to-load-path "~/.emacs.d/plugins/xcscope")
(require 'xcscope)


;; package manager
(setq package-archives '(("ELPA" . "http://tromey.com/elpa/")
                          ("gnu" . "http://elpa.gnu.org/packages/")
                          ("marmalade" . "http://marmalade-repo.org/packages/")))

;; powershell-mode
(wttr/prepend-to-load-path "~/.emacs.d/plugins/powershell-mode-0.5")
(autoload 'powershell-mode "powershell-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.ps[12]?$" . powershell-mode))

;; undo tree mode
(wttr/prepend-to-load-path "~/.emacs.d/plugins/undo-tree-0.3")
(require 'undo-tree)
(global-undo-tree-mode)

;; ido mode
(when (require 'ido "ido" t)
  (ido-mode t)
  (setq ido-enable-flex-matching t)
  (setq ido-use-virtual-buffers t))


;; turn off blinding cursor 
(when (fboundp 'blink-cursor-mode)
  (blink-cursor-mode -1)) 

;; tempbuf mode
(wttr/prepend-to-load-path "~/.emacs.d/plugins/tempbuf-mode")
(require 'tempbuf)
(add-hook 'help-mode-hook 'turn-on-tempbuf-mode)
(add-hook 'grep-mode-hook 'turn-on-tempbuf-mode)

;; sr-speedbar
;(wttr/prepend-to-load-path "~/.emacs.d/plugins/sr-speedbar-0.1.8/")
;(require 'sr-speedbar)
;(setq sr-speedbar-right-side nil)
;(setq speedbar-show-unknown-files nil)

(wttr/prepend-to-load-path "~/.emacs.d/plugins/csharp-mode")
(autoload 'csharp-mode "csharp-mode-0.8.5" nil t)
(add-to-list 'auto-mode-alist '("\\.cs$" . csharp-mode))

;(wttr/prepend-to-load-path "~/.emacs.d/plugins/anything")
;(require 'anything-config)


;; elisp mode setting
;; (add-hook 'emacs-lisp-mode-hook
;;           #'wttr/delete-trailing-whitespace-when-save)
;(add-hook 'emacs-lisp-mode-hook 'imenu-add-menubar-index)

;; c-mode setting
;; (add-hook 'c-mode-hook
;;           #'wttr/delete-trailing-whitespace-when-save)
;(add-hook 'c-mode-hook 'imenu-add-menubar-index)


;; tramp
;; 1. Download putty installer with all the tools.
;; 2. Put putty install in the path
;; 3. Generate a key with PuttyGen
;; 4. Copy public key to your server
;; 5. Append public key to your .ssh/authorized_keys file (be sure to
;; remove extraneous puttygen text, just get the key)
;; 6. Load up pageant and add your private key (this can be automated
;; on windows boot)
;; 7. Add the following to your .emacs config

;; As long as pageant is running with your key, you can edit your
;; remote files using the format ssh://user@server:path/to/file
;; (require 'tramp)
(setq default-tramp-method "plink")

;; F# mode
(wttr/prepend-to-load-path "~/.emacs.d/plugins/fsharp-mode")
(add-to-list 'auto-mode-alist '("\\.fs[iylx]?$" . fsharp-mode))
(autoload 'fsharp-mode "fsharp" "Major mode for editing F# code." t)
(autoload 'run-fsharp "inf-fsharp" "Run an inferior F# process." t)

(cond
 (wttr/host:MSWSp
  (setq inferior-fsharp-program "\"C:/Program Files (x86)/Microsoft F#/v4.0/Fsi.exe\"")
  (setq fsharp-compiler "\"C:/Program Files (x86)/Microsoft F#/v4.0/Fsc.exe\""))
 (wttr/host:HOMEp
  (setq inferior-fsharp-program "\"C:/Program Files/Microsoft F#/v4.0/Fsi.exe\"")
  (setq fsharp-compiler "\"C:/Program Files/Microsoft F#/v4.0/Fsc.exe\""))
 (t
  nil))

;; redo tree
(setq undo-tree-mode-lighter " UndoT")


;; expand-region
(wttr/prepend-to-load-path "~/.emacs.d/plugins/expand-region")
(autoload 'er/expand-region "expand-region" "auto expand region" t)
(global-set-key (kbd "M-2") 'er/expand-region)

;; wrap-region
(wttr/prepend-to-load-path "~/.emacs.d/plugins/wrap-region")
(require 'wrap-region)
(wrap-region-global-mode t)
; (wrap-region-add-wrappers
;  '(("$" "$")
;    ("{-" "-}" "#")
;    ("/" "/" nil 'ruby-mode)
;    ("/* " " */" "#" '(java-mode javascript-mode css-mode))
;    ("`" "`" nil '(markdown-mode ruby-mode))))
; (add-to-list 'wrap-region-except-modes 'conflicting-mode)


;; ispell setting
(autoload 'ispell-buffer "ispell" "spell check the current buffer" t)
(when wttr/os:win32p
  (wttr/prepend-to-exec-path "~/.emacs.d/extra-bin/aspell/bin")
  (setq ispell-program-name "aspell"))
(setq ispell-dictionary "british")


;; uniquify setting
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

;; hide lines
(wttr/prepend-to-load-path "~/.emacs.d/plugins/hide-lines")
(autoload 'hide-lines "hide-lines" nil t)


;; action script mode
(wttr/prepend-to-load-path "~/.emacs.d/plugins/action-script-mode")
(autoload 'actionscript-mode "actionscript-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.as$" . actionscript-mode))

(provide 'wttr-minor-modes)