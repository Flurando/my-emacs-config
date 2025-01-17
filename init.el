(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

(setq inferior-lisp-program (executable-find "sbcl"))
(setq sly-lisp-implementations
      '((sbcl ("sbcl"))
	(clisp ("clisp"))))

;;Wesnoth WML mode
(add-to-list 'load-path "/home/jack/apps/wesnoth-mode/")
(autoload 'wesnoth-mode "wesnoth-mode" "Major mode for editing WML." t)

;;scheme lsp
(require 'eglot)
(add-to-list 'eglot-server-programs
	     `(scheme-mode . ("guile-lsp-server")))
;(add-hook 'scheme-mode-hook #'eglot-ensure) ;uncomment this line only when automatic start is desired, but to my test the guile-lsp-server is doing nothing about enhancing geiser, only making life harder unfortunately
(setq scheme-program-name "guile")

;;change *scratch* content
(setq initial-scratch-message
"Make it happen, or let it go.
Life is simple like a show.

Face the darkest, or hide the fist.
Magic swarms in the mist.

Never mind.
Only regret the regrets.
Please don't stop.
Follow the call from the past.

")
