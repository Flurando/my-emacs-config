(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(display-time-day-and-date t)
 '(display-time-format "[%Y.%m.%d<%W>%H:%M:%S(%Z)]")
 '(display-time-mode t)
 '(mode-line-percent-position nil)
 '(package-selected-packages '(cdlatex geiser-guile rust-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :extend nil :stipple nil :background "black" :foreground "yellow" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight regular :height 300 :width normal :foundry "GOOG" :family "Noto Sans Mono"))))
 '(mode-line ((t (:background "black" :foreground "gold" :box (:line-width (1 . -1) :style released-button)))))
 '(mode-line-inactive ((t (:inherit mode-line :background "grey30" :foreground "grey80" :box (:line-width (1 . -1) :color "grey40") :weight light)))))

;; Execute and update the dpi
(shell-command "echo 'Xft.dpi: 300' | xrdb")

;;;some config that should be toggled before exwm
;; Protect the hard links
(setq backup-by-copying-when-linked t)
;; Ban the Welcome Screen when starting emacs
(setq inhibit-startup-screen t)
;; Change the mode used by *scratch*
(setq initial-major-mode 'eshell-mode)
;; Disable the eshell welcome message
(setq eshell-banner-message "")
;; Disable menu-bar, tool-bar and scroll-bar to increase the usable space.
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
;; Also shrink fringes to 1 pixel.
(fringe-mode 1)
;; Show battrey status in the mode line
(display-battery-mode 1)
;; Alter the behavior of 'C-x b' as proposed
(icomplete-vertical-mode 1)
;; Start the server if there is no running server, though not required, making things more interesting
(defun safe-start-server ()
  (if (and (fboundp 'server-running-p)
	   (not (server-running-p)))
      (server-start)))
(safe-start-server)

;;;exwm
(require 'exwm)
(setq exwm-workspace-number 2)
(add-hook 'exwm-update-class-hook
	  (lambda ()
	    (unless (or (string-prefix-p "sun-awt-X11-" exwm-instance-name)
			(string= "gimp" exwm-instance-name))
	      (exwm-workspace-rename-buffer exwm-class-name))))
(add-hook 'exwm-update-title-hook
	  (lambda ()
	    (when (or (not exwm-instance-name)
		      (string-prefix-p "sun-awt-X11-" exwm-instance-name)
		      (string= "gimp" exwm-instance-name))
	      (exwm-workspace-rename-buffer exwm-title))))
(setq exwm-input-global-keys
      `(([?\s-r] . exwm-reset) ;; s-r: Reset (to line-mode).
	([?\s-w] . exwm-workspace-switch) ;; s-w: Switch workspace.
	([?\s-`] . (lambda ()
		     (interactive)
		     (exwm-workspace-switch-create 0)))
	([?\s-&] . (lambda (cmd) ;; s-&: Launch application.
		     (interactive (list (read-shell-command "$ ")))
		     (start-process-shell-command cmd nil cmd)))
	,@(mapcar (lambda (i)
		    `(,(kbd (format "s-%d" i)) .
		      (lambda ()
			(interactive)
			(exwm-workspace-switch-create ,i))))
		  (number-sequence 0 9))
	;;Move between windows
	([s-left] . windmove-left)
	([s-right] . windmove-right)
	([s-up] . windmove-up)
	([s-down] . windmove-down)))

(setq exwm-input-simulation-keys
      '(
	;; movement
	([?\C-b] . [left])
	([?\M-b] . [C-left])
	([?\C-f] . [right])
	([?\M-f] . [C-right])
	([?\C-p] . [up])
	([?\C-n] . [down])
	([?\C-a] . [home])
	([?\C-e] . [end])
	([?\M-v] . [prior])
	([?\C-v] . [next])
	([?\C-d] . [delete])
	([?\C-k] . [S-end delete])
	;; cut/paste
	([?\C-w] . [?\C-x])
	([?\M-w] . [?\C-c])
	([?\C-y] . [?\C-v])
	;; search
	([?\C-s] . [?\C-f])))
(setq exwm-input-prefix-keys
      '(?\C-x
	?\C-u
	?\C-h
	?\M-x
	?\M-`
	?\M-:
	?\C-\M-j ; Buffer list
	?\C-\ )) ; Ctrl+Space

;; Ctrl+Q will enable the next key to be sent directly
(define-key exwm-mode-map [?\C-q] 'exwm-input-send-next-key)

;; You can hide the minibuffer and echo area when they're not used, by uncommenting the following line.
;(setq exwm-workspace-minibuffer-position 'bottom)

;; load init.el
(load "~/.emacs.d/init.el")

;; Try to start server again
(safe-start-server)

;; Enable exwm when things are ready
(exwm-enable)

;; Toggle on exwm-wim for chinese input
(exwm-xim-mode 1)

;; Just confirm that a server is started
(safe-start-server)
