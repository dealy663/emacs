;; manual config file guided from system crafters  -*- lexical-binding: t; -*-

;; Don't display startup message
(setq inhibit-startup-message t
      visible-bell t)


;; set option key on mac to be meta
(setq mac-option-modifier 'meta)

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; set modus theme optinons
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (require-theme 'modus-themes)

(setq modus-themes-mode-line '(borderless accented padded))
(setq modus-themes-region '(bg-only))
(setq modus-themes-bold-constructs t
      modus-themes-italic-constructs t
      modus-themes-paren-match '(bold intense underline))
(setq modus-themes-italic-constructs t)
(setq modus-themes-syntax '(alt-syntax faint))

;; (setq modus-themes-common-palette-overrides 1)
;; (setq modus-themes-preset-overrides-intense 1)
(setq modus-themes-completion 'opinionated)

;; ;; ;; all modus theme cusomizations must be done before the theme is loaded
;; ;; ;;(load-theme 'modus-vivendi t)
(load-theme 'modus-vivendi-deuteranopia t)

;; (define-key global-map (kbd "<f5>")  #'modus-themes-toggle)

;; package.el disabled — straight.el manages packages instead
;; (see early-init.el for package-enable-at-startup nil)
(setq straight-use-package-by-default t)
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; use some packages
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (use-package command-log-mode)

;; ;; configure Ivy completion
;; (use-package ivy
;;   :diminish
;;   :bind (("C-s" . swiper)
;;          :map ivy-minibuffer-map
;;          ("TAB" . ivy-alt-done)	
;;          ("C-l" . ivy-alt-done)
;;          ("C-j" . ivy-next-line)
;;          ("C-k" . ivy-previous-line)
;;          :map ivy-switch-buffer-map
;;          ("C-k" . ivy-previous-line)
;;          ("C-l" . ivy-done)
;;          ("C-d" . ivy-switch-buffer-kill)
;;          :map ivy-reverse-i-search-map
;;          ("C-k" . ivy-previous-line)
;;          ("C-d" . ivy-reverse-i-search-kill))
;;   :config
;;   (ivy-mode 1))
;; (custom-set-variables
;;  ;; custom-set-variables was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(package-selected-packages '(command-log-mode ivy)))
;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  )



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Configure straight.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Import shell environment (needed because GUI Emacs launched from the
;;  Dock/Spotlight is started by launchd, which never sources ~/.zshrc, so
;;  vars like ANTHROPIC_API_KEY would otherwise be missing)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package exec-path-from-shell
  :config
  (dolist (var '("ANTHROPIC_API_KEY" "OPENAI_API_KEY"))
    (add-to-list 'exec-path-from-shell-variables var))
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Configure co-pilot integration
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package editorconfig)
(use-package jsonrpc)

(use-package copilot
  :straight (:host github :repo "copilot-emacs/copilot.el" :files ("*.el"))
  :ensure t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Configure Magit
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package magit
  :bind ("C-x g" . magit-status))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Configure Python IDE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package python-mode
  :ensure nil
  :hook (python-mode . eglot-ensure)
  :custom
  (python-shell-interpreter "python3"))

(custom-set-faces)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Configure C/C++ with clangd via eglot
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-hook 'c-mode-hook #'eglot-ensure)
(add-hook 'c++-mode-hook #'eglot-ensure)
(add-hook 'c-ts-mode-hook #'eglot-ensure)
(add-hook 'c++-ts-mode-hook #'eglot-ensure)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Configure Rust
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package emacs
  :init
  ;; Automatically map Rust files to the native Tree-sitter major mode
  (add-to-list 'major-mode-remap-alist '(rust-mode . rust-ts-mode))
  
  :hook
  ;; Automatically start the LSP server whenever you open a Rust file
  (rust-ts-mode . eglot-ensure))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Configure Claude integration 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; --- 1. Package Infrastructure (Straight / use-package) ---
;; (use-package gptel
;;   :ensure t
;;   :config
;;   (setq gptel-model 'claude-3-5-sonnet-latest ; Default to Claude 3.5 Sonnet
;;         gptel-backend (gptel-make-anthropic "Claude" :key (getenv "ANTHROPIC_API_KEY"))))

;; ;; --- 2. MCP Hub & Client Integration ---
;; ;; Manages external tool servers (filesystem, bash, code lenses)
;; (use-package mcp-hub
;;   :straight (:host github :repo "lizqwerscott/mcp.el")
;;   :config
;;   (setq mcp-hub-servers
;;         `(("filesystem" . (:command "npx" :args ("-y" "@modelcontextprotocol/server-filesystem" ,(expand-file-name "~"))))
;;           ("bash-runner" . (:command "uvx" :args ("mcp-server-bash")))))
;;   (mcp-hub-start-all-server))

;; ;; --- 3. Pure Elisp Emacs MCP Server ---
;; ;; Exposes Emacs internal context (Python/C++ open buffers, project trees) to Claude
;; (use-package mcp-server
;;   :straight (:host github :repo "rhblind/emacs-mcp-server"
;;              :files ("*.el" "tools/*.el"))
;;   :config
;;   (mcp-server-start-unix))

;; (use-package gptel
;;   :config
;;   (setq gptel-model 'claude-opus-5)
;;   (gptel-make-anthropic "Claude"
;;     :stream t
;;     :key (getenv "ANTHROPIC_API_KEY")))

(use-package gptel
  :config
  (setq gptel-backend
        (gptel-make-anthropic "Claude"
          :stream t
          :key #'gptel-api-key-from-auth-source))
  (setq gptel-model 'claude-sonnet-4-6)
  ;; Visually distinguish Claude's responses from your own input: a
  ;; background tint on response text plus a margin marker.
  (setq gptel-highlight-methods '(face margin))
  (add-hook 'gptel-mode-hook #'gptel-highlight-mode))

(add-hook 'gptel-post-response-functions (lambda (_ _) (goto-char (point-max))))
