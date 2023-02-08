(setq inhibit-startup-message t) ; skip the startup screen
(scroll-bar-mode -1) ; disable the scroll bar
(tool-bar-mode -1) ; disable the tool abr
(set-fringe-mode 10) ; give some breathing room
(menu-bar-mode -1) ; disable the menu bar
(setq visible-bell t) ; set up the visible bell
(blink-cursor-mode 0) ; disable the blinking cursor

(set-face-attribute 'default nil :font "Hack" :height 100) ; set font
;;(set-face-attribute 'default nil :font "Hurmit Nerd Font medium" :height 96) ; set font

;; make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; initialize package sources
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("944d52450c57b7cbba08f9b3d08095eb7a5541b0ecfb3a0a9ecd4a18f3c28948" "a138ec18a6b926ea9d66e61aac28f5ce99739cf38566876dc31e29ec8757f6e2" "467dc6fdebcf92f4d3e2a2016145ba15841987c71fbe675dcfe34ac47ffb9195" "e3daa8f18440301f3e54f2093fe15f4fe951986a8628e98dcd781efbec7a46f2" "49acd691c89118c0768c4fb9a333af33e3d2dca48e6f79787478757071d64e68" "a589c43f8dd8761075a2d6b8d069fc985660e731ae26f6eddef7068fece8a414" "4ff1c4d05adad3de88da16bd2e857f8374f26f9063b2d77d38d14686e3868d8d" "443e2c3c4dd44510f0ea8247b438e834188dc1c6fb80785d83ad3628eadf9294" "f64189544da6f16bab285747d04a92bd57c7e7813d8c24c30f382f087d460a33" "be84a2e5c70f991051d4aaf0f049fa11c172e5d784727e0b525565bb1533ec78" "7e068da4ba88162324d9773ec066d93c447c76e9f4ae711ddd0c5d3863489c52" "05626f77b0c8c197c7e4a31d9783c4ec6e351d9624aa28bc15e7f6d6a6ebd926" default))
 '(ispell-dictionary nil)
 '(package-selected-packages
   '(modus-themes org-roam-ui org-roam org-bullets org org-translate orgalist magit vterm all-the-icons doom-modeline doom-themes ivy-rich which-key quelpa quelpa-use-package snow rainbow-delimiters multi-term dracula-theme minimap counsel ivy command-log-mode use-package cmake-mode))
 '(send-mail-function 'mailclient-send-it))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-level-1 ((t (:inherit outline-1 :height 1.15))))
 '(org-level-2 ((t (:inherit outline-2 :height 1.1))))
 '(org-level-3 ((t (:inherit outline-3 :height 1.05))))
 '(org-level-4 ((t (:inherit outline-4 :height 1.0))))
 '(org-level-5 ((t (:inherit outline-5 :height 1.0)))))

;; Set theme
;; theme packages
(use-package doom-themes)
;; load theme
(load-theme 'doom-dracula)
;(load-theme 'doom-nord-light)
;(load-theme 'doom-molokai)
;(load-theme 'doom-snazzy)
;(load-theme 'doom-zenburn)
;(load-theme 'doom-gruvbox-light)
;(load-theme 'doom-acario-light)
;(load-theme 'doom-flatwhite)




(use-package command-log-mode)

;; include counsel package for searching
(use-package counsel
 :bind(("M-x" . counsel-M-x)
	("C-x b" . counsel-ibuffer)
	("C-x C-f" . counsel-find-file)
	:map minibuffer-local-map
	("C-r" . 'counsel-minibuffer-history))
  :config
  (setq ivy-initial-inputs-alist nil))



;; overwrite selected text
(delete-selection-mode 1)

;; beacon
(beacon-mode 1)
(setq beacon-color "#E2F516")

;; minimap
(minimap-mode 0)
(setq minimap-window-location 'right)

; set transparency
;(set-frame-parameter (selected-frame) 'alpha '(98 98))
;(add-to-list 'default-frame-alist '(alpha 98 98))

;; set org mode font sizes

;; use rainbow delimeters
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; line numbers
(column-number-mode)
(global-display-line-numbers-mode t)

;; org
(use-package org
  :ensure t)
;; set directory for org agenda
(defun my-org-files ()
  "Return a list of all .org files in the ~/Analysis/org directory and its subdirectories."
  (directory-files-recursively "~/Analysis/org" "\.org$"))
(setq org-agenda-files (my-org-files))
;; refresh the org-agenda whenever I save one of my org files
;;(add-hook 'after-save-hook 'org-save-all-org-buffers)

;; org bullets
(use-package org-bullets
    :config
    (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

;; org key-binds (from org-manual)
(global-set-key (kbd "C-c l") #'org-store-link)
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)


;; which-key function -- displays the key-bindings in a lower window
(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 1.0))

;; ivy
(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

;; ivy-rich, display desciptive information about M-x commands
(use-package ivy-rich
  :init
  (ivy-rich-mode 1))


;; NOTE: The first time you load your configuration on a new machine, you'll
;; need to run the following command interactively so that mode line icons
;; display correctly:
;;
;; M-x all-the-icons-install-fonts

(use-package all-the-icons)

(setq doc-view-scale-internally nil)

;; set TODO types
(setq org-todo-keywords '((type "TODO" "IN PROGRESS" "WAIT" "|" "DONE")))

;; set TODO tags
(setq org-tag-alist '(("@Analysis" . ?A) ("@CERN" . ?C) ("@FNAL" . ?F) ("@UIC" . ?U) ("@Personal" . ?P)
		      ("@HLT" . ?H) ("@AlCaDB" . ?D)
		      ("@muons" . ?m) ("@jets" . ?j) ("@trigger" . ?t) ("@jetFlavor" . ?r) ("@ghosts" . ?x)
		      ("@jetReconstruction" . ?q) ("@muonReconstruction" . ?w) ("@templates" . ?y)
		      ("@fits" . ?f) ("@pixels" . ?z) ("@forests" . ?u)))


;; display diary for the day
(diary)


;; org-roam
(use-package org-roam
  :ensure t
  :custom
  (org-roam-directory "~/RoamNotes")
  :bind (("C-c n l" . org-roam-buffer-toggle)
	 ("C-c n f" . org-roam-node-find)
	 ("C-c n i" . org-roam-node-insert))
  :config
  (org-roam-setup)
  )


