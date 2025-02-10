(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(display-time-day-and-date t)
 '(display-time-format "[%Y.%m.%d-%H:%M:%S(%Z)]")
 '(display-time-mode nil)
 '(erc-modules
   '(autojoin button completion fill irccontrols list match menu move-to-prompt netsplit networks noncommands readonly ring sasl stamp track))
 '(mode-line-percent-position nil)
 '(mouse-wheel-down-alternate-event 'wheel-down)
 '(mouse-wheel-down-event 'mouse-5)
 '(mouse-wheel-tilt-scroll t)
 '(mouse-wheel-up-alternate-event 'wheel-up)
 '(mouse-wheel-up-event 'mouse-4)
 '(package-selected-packages '(cdlatex geiser-guile rust-mode))
 '(tool-bar-mode nil)
 '(xterm-mouse-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :extend nil :stipple nil :background "black" :foreground "yellow" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight regular :height 300 :width normal :foundry "GOOG" :family "Noto Sans Mono"))))
 '(mode-line ((t (:background "black" :foreground "gold" :box (:line-width (1 . -1) :style released-button)))))
 '(mode-line-inactive ((t (:inherit mode-line :background "grey30" :foreground "grey80" :box (:line-width (1 . -1) :color "grey40") :weight light)))))

;;;some config that should be toggled before exwm
;; Protect the hard links
(setq backup-by-copying-when-linked t)
;; Ban the Welcome Screen when starting emacs
(setq inhibit-startup-screen t)
;; Change the mode used by *scratch*
(setq initial-major-mode 'fundamental-mode)
;; Disable the eshell welcome message
(setq eshell-banner-message "")
;; Disable menu-bar, scroll-bar to increase the usable space.
(menu-bar-mode -1)
(scroll-bar-mode -1)
;; Also shrink fringes to 1 pixel.
(fringe-mode 1)
;; Alter the behavior of 'C-x b' as proposed
(icomplete-vertical-mode 1)

;; load exwm without really switching to it
;(load "~/.emacs.d/exwm/exwm.el")

;; load init.el
(load "~/.emacs.d/init.el")
