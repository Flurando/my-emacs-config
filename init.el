(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(backup-by-copying-when-linked t)
 '(display-time-format "[%Y.%m.%d-%H:%M:%S(%Z)]")
 '(display-time-mode nil)
 '(erc-modules
   '(autojoin button completion fill irccontrols list match menu move-to-prompt netsplit networks noncommands readonly ring sasl stamp track))
 '(fringe-mode 1 nil (fringe))
 '(icomplete-vertical-mode t)
 '(ido-mode nil nil (ido))
 '(inferior-lisp-program "sbcl")
 '(inhibit-startup-screen t)
 '(initial-major-mode 'fundamental-mode)
 '(initial-scratch-message
   "Make it happen, or let it go.\12Life is simple like a show.\12\12Face the darkest, or hide the fist.\12Magic swarms in the mist.\12\12Never mind what being met.\12Only weep for the regret.\12\12Please insist till the last.\12Follow the call from the past.\12\12")
 '(ivy-mode t)
 '(menu-bar-mode nil)
 '(mode-line-percent-position nil)
 '(mouse-wheel-down-alternate-event 'wheel-down)
 '(mouse-wheel-down-event 'mouse-5)
 '(mouse-wheel-tilt-scroll t)
 '(mouse-wheel-up-alternate-event 'wheel-up)
 '(mouse-wheel-up-event 'mouse-4)
 '(package-archives
   '(("gnu" . "https://elpa.gnu.org/packages/")
     ("nongnu" . "https://elpa.nongnu.org/nongnu/")
     ("melpa" . "https://melpa.org/packages/")))
 '(package-enable-at-startup nil)
 '(package-install-upgrade-built-in t)
 '(package-selected-packages
   '(compat magit guix sly system-packages geiser wesnoth-mode quelpa-use-package quelpa cdlatex geiser-guile))
 '(scheme-program-name "guile")
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :extend nil :stipple nil :background "black" :foreground "yellow" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight regular :height 300 :width normal :foundry "GOOG" :family "Noto Sans Mono"))))
 '(mode-line ((t (:background "black" :foreground "gold" :box (:line-width (1 . -1) :style released-button)))))
 '(mode-line-inactive ((t (:inherit mode-line :background "grey30" :foreground "grey80" :box (:line-width (1 . -1) :color "grey40") :weight light)))))

;; Actually use-package is available by default in newer emacs, but whatever!
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(use-package use-package-ensure-system-package)

;; Enable :ensure-system-package in use-package
;; by default, it uses guix to install not available stuff
;; pass string for other cases
(use-package system-packages :ensure t)

;; Set up quelpa and enable :quelpa in use-package
;; Caution: don't :ensure t and :quelpa (...) at the same time
(use-package quelpa
  :ensure t
  :custom
  (quelpa-update-melpa-p nil))
(use-package quelpa-use-package :ensure t)

;; Some stuff required when guix and melpa is conflicting
(use-package compat :ensure t)
(use-package dash :ensure t)

;; Wesnoth WML mode
(use-package wesnoth-mode
  :ensure-system-package git
  :quelpa
  (wesnoth-mode :fetcher git
		:url "git://repo.or.cz/wesnoth-mode.git"
		:build (:not compile))
  :config
  (autoload 'wesnoth-mode "wesnoth-mode" "Major mode for editing WML." t))

(use-package eshell
  :init
  (setq eshell-banner-message ""))

;; Sly, the must-have for commonlisp work in emacs
;; Caution: up to my experience, sbcl installed by guix is faulty in a manner that gnome might be broken by it -- some pointed out that changing some environment variables like XDG_DATA_DIRS manually can fix, but that is not true for me and I recommend you to check the issue yourself at bug-guix bug#45360 -- not fixed and nearly 0 hope of being fixed in the future. You might want to avoid that by hand! Just in case, if one happens to have guix available but no sbcl installed already.
(use-package sly
  :ensure t
  :ensure-system-package sbcl)
;;(use-package sly-quicklisp :ensure t :after sly)
;;(use-package sly-named-readtables :ensure t :after sly)
;;(use-package sly-macrostep :ensure t :after sly)
;;(use-package sly-stepper :ensure t :after sly)
;;(use-package sly-asdf :ensure t :after sly)
;;(use-package sly-named-readtables :ensure t :after sly)

;; emacs-guix, the guix interface
(use-package guix
  :ensure t
  :ensure-system-package guix)

;; Geiser, the slime/sly (Common Lisp) equivalence in Scheme world
(use-package geiser
  :ensure t
  :ensure-system-package guile
  :custom
  (geiser-active-implementations '(guile)))
(use-package geiser-guile
  :ensure t
  :ensure-system-package guile
  :after geiser
  :custom
  (geiser-guile-binary (executable-find "guile"))
  (geiser-guile-load-path nil)
  (geiser-guile-load-init-file t))

;; Auto completion
(use-package ivy
  :ensure t)
(use-package swiper
  :ensure t
  :after ivy)
(use-package counsel
  :ensure t
  :after (:all ivy swiper)
  :custom
  (counsel-linux-app-format-function #'counsel-linux-app-format-function-name-only))

;; Magit, the git interface for emacs
(use-package magit
  :ensure t
  :ensure-system-package git)
