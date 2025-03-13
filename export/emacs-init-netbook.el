;; [[file:../emacs-init-netbook.org::*Personal constants][Personal constants:1]]
(defconst SAVES_DIR
  "/mnt/data/misc/file-saves")

(defconst YAS_SNIPPET_DIR
  "/mnt/data/projects/yas-snippets")
;; Personal constants:1 ends here

;; [[file:../emacs-init-netbook.org::*Global modes][Global modes:1]]
(column-number-mode)
(scroll-bar-mode -1)        ; Disable visible scrollbar.
(tool-bar-mode -1)          ; Disable the toolbar.
(tooltip-mode -1)           ; Disable tooltips.
(set-fringe-mode 10)        ; Give some breathing room ???.
(menu-bar-mode -1)          ; Disable menu bar.
(setq visible-bell t)       ; Do not beep.
(recentf-mode t)            ; Store history of recent files.

(global-auto-revert-mode 1) ; Watch files for changes.
(setq global-auto-revert-non-file-buffers t) ; For, e.g., Dired.

(add-hook 'prog-mode-hook 'display-line-numbers-mode)

(global-subword-mode)      ; Yes! Hop in Open|Ai|Embeddings like open_ai_embeddings.
;; Global modes:1 ends here

;; [[file:../emacs-init-netbook.org::*Main font][Main font:1]]
(set-face-attribute
 'default
 nil
 :font "JetBrains Mono"
 :height 98
 :weight 'regular
 :slant 'normal
 :width 'normal)
;; Main font:1 ends here

;; [[file:../emacs-init-netbook.org::*Backups][Backups:1]]
(setq backup-directory-alist `(("." . ,SAVES_DIR)))
(setq backup-by-copying t)

(setq delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)
;; Backups:1 ends here

;; [[file:../emacs-init-netbook.org::*Package setup][Package setup:1]]
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))
;; Package setup:1 ends here

;; [[file:../emacs-init-netbook.org::*=use-package=][=use-package=:1]]
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)
;; =use-package=:1 ends here

;; [[file:../emacs-init-netbook.org::*Multi-term][Multi-term:1]]
(use-package multi-term
  :custom
  (multi-term-program "/bin/zsh"))
;; Multi-term:1 ends here

;; [[file:../emacs-init-netbook.org::*Copy/pasting][Copy/pasting:1]]
(use-package xclip
  :config
  (xclip-mode 1))
;; Copy/pasting:1 ends here

;; [[file:../emacs-init-netbook.org::*Flycheck][Flycheck:1]]
(use-package flycheck)
;; Flycheck:1 ends here

;; [[file:../emacs-init-netbook.org::*LSP][LSP:1]]
(use-package lsp-mode
  :commands lsp
  :custom
  ;; what to use when checking on-save. "check" is default, I prefer clippy
  (lsp-rust-analyzer-cargo-watch-command "clippy")
  (lsp-eldoc-render-all t)
  (lsp-idle-delay 0.6)
  ;; enable / disable the hints as you prefer:
  (lsp-inlay-hint-enable t)
  ;; These are optional configurations. See https://emacs-lsp.github.io/lsp-mode/page/lsp-rust-analyzer/#lsp-rust-analyzer-display-chaining-hints for a full list
  ;; (lsp-rust-analyzer-display-lifetime-elision-hints-enable "skip_trivial")
  ;; (lsp-rust-analyzer-display-chaining-hints t)
  ;; (lsp-rust-analyzer-display-lifetime-elision-hints-use-parameter-names nil)
  ;; (lsp-rust-analyzer-display-closure-return-type-hints t)
  ;; (lsp-rust-analyzer-display-parameter-hints nil)
  ;; (lsp-rust-analyzer-display-reborrow-hints nil)
  :config
  (add-hook 'lsp-mode-hook 'lsp-ui-mode))

(use-package lsp-ui
  :commands lsp-ui-mode
  :custom
  (lsp-ui-peek-always-show t)
  (lsp-ui-sideline-show-hover t)
  (lsp-ui-doc-enable nil))
;; LSP:1 ends here

;; [[file:../emacs-init-netbook.org::*Rust][Rust:1]]
(use-package rustic
  :bind
  (:map rustic-mode-map
        ("M-j" . lsp-ui-imenu)
        ("M-?" . lsp-find-references)
        ("C-c C-c l" . flycheck-list-errors)
        ("C-c C-c a" . lsp-execute-code-action)
        ("C-c C-c r" . lsp-rename)
        ("C-c C-c q" . lsp-workspace-restart)
        ("C-c C-c Q" . lsp-workspace-shutdown)
        ("C-c C-c s" . lsp-rust-analyzer-status))
  
  :custom
  (rustic-rustfmt-config-alist '((edition . "2021")))
  
  (lsp-eldoc-hook nil)
  (lsp-enable-symbol-highlighting nil)
  (lsp-signature-auto-activate nil)

  (rustic-format-on-save t))
;; Rust:1 ends here

;; [[file:../emacs-init-netbook.org::*=yasnippet=][=yasnippet=:1]]
(use-package yasnippet
  :hook
  (prog-mode . yas-minor-mode)
  (text-mode . yas-minor-mode)

  :custom
  (yas-snippet-dirs (list YAS_SNIPPET_DIR))

  :config
  (yas-reload-all))
;; =yasnippet=:1 ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(eldoc-documentation-functions nil t nil "Customized with use-package rustic")
 '(package-selected-packages '(company lsp-ui multi-term rustic xclip yasnippet)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
