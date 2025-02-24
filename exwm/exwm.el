;;;exwm
(use-package exwm
  :ensure t
  :config
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
	  ([s-down] . windmove-down)
	  ;;Support quick switch line/char mode in gui apps
	  ([?\s-o] . exwm-input-toggle-keyboard)))

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
  ;;(setq exwm-workspace-minibuffer-position 'bottom)

  ;; For counsel-linux-app
  (exwm-input-set-key (kbd "s-SPC") 'counsel-linux-app)
  (exwm-input-set-key (kbd "s-f") 'exwm-layout-toggle-fullscreen)
  
  ;; simple system tray
  (require 'exwm-systemtray)
  (exwm-systemtray-mode 1))

(use-package desktop-environment
  :ensure t
  :ensure-system-package (scrot brightnessctl playerctl)
  :after exwm
  :config (desktop-environment-mode)
  :custom
  (desktop-environment-brightness-small-increment "2%+")
  (desktop-environment-brightness-small-decrement "2%-")
  (desktop-environment-brightness-normal-increment "5%+")
  (desktop-environment-brightness-normal-decrement "5%-"))
