;; manual config file guided from system crafters

;; Don't display startup message
;; (setq inhibit-startup-message t
;;       visible-bell t)

;; Turn off some unneeded UI elements
(menu-bar-mode -1)  ; Leave this one on if you're a beginner!
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; keep track of recently opened files
(recentf-mode 1)

;; Display line numbers in every buffer
(global-display-line-numbers-mode 1)

;; save history of minibuffer inputs
(setq history-length 25)
(savehist-mode 1)

;; remember the last place you visited a file
(save-place-mode 1)

;; Revert buffers when the underlying file has changed
(global-auto-revert-mode 1)
(setq global-auto-revert-non-file-bufferst 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Setup themes
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;(require 'modus-themes)
;;(setq modus-themes-mode-line '(borderless))
(setq modus-themes-mode-line '(accented padded borderless))
;;(setq modus-themes-region '(accented))
(setq modus-themes-completions 'opinionated)
;;(setq modus-themes-region '(accented))
(setq modus-themes-region '(bg-only))

;; Theme options must be set before loading the theme
(load-theme 'modus-vivendi t)
