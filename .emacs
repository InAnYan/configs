;; Previewing latex fragments in org mode
(setq org-latex-create-formula-image-program 'imagemagick) ;; Recommended to use imagemagick

(load "auctex.el" nil t t)
; (load "preview-latex.el" nil t t)
(setq LaTeX-command "latex -shell-escape")

;; Treat PascalStyle as separate words.
(global-subword-mode)

;; Some shr settings.
(setq-default shr-width 80)
(setq-default shr-max-width 80)

;; Maximize Emacs window (frame).
(toggle-frame-maximized)

;; Make -> as arrow. Make lambda as Greek lambda, and so on.
(setq prettify-symbols-alist
      '(
        ("lambda" . 955) ; λ
        ("->" . 8594)    ; →
        ("=>" . 8658)    ; ⇒
        ("map" . 8614)   ; ↦
        ))
(global-prettify-symbols-mode)

;; Disable menu bar.
(menu-bar-mode -1)
;; Disable scroll bar.
(scroll-bar-mode -1)
;; Disable tool bar.
(tool-bar-mode -1)

;; Set tab size to 4.
(setq-default tab-width 4)

;; Use spaces instead of tabs.
(setq-default indent-tabs-mode nil)

;; Auto pair.
(electric-pair-mode 1)

;; Enable line numbers.
(global-display-line-numbers-mode)

;; Replace selected text.
(delete-selection-mode 1)

(setq package-archives '(("elpa" . "http://tromey.com/elpa/")
                         ("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
			 ("melpa" . "https://melpa.org/packages/"))

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(require 'use-package)

(use-package exec-path-from-shell
  :if (memq window-system '(mac ns))
  :ensure t
  :config
  (exec-path-from-shell-initialize))

(use-package dired-x
	     :ensure t
	     :custom
	     (dired-omit-files "^\\.[^.]\\|\\.cache\\|\\.emacs_saves\\|\\.git\\|.*.d$\\|.*.o$\\|.*#$"))

;; Which key. (What is this?).
(use-package which-key
	     :ensure t
             :config
	     (which-key-mode))

;; Enable Evil.
(use-package evil
	     :ensure t
	     :config
 	     (evil-mode 1))

;; Use rust-mode.
(use-package rust-mode
	     :ensure t)

;; Use lsp-mode.
(use-package lsp-mode
	     :ensure t
	     :hook ((c++-mode-hook . lsp)
		    (rust-mode-hook . lsp)))

;; Use lsp-ui.
(use-package lsp-ui
	     :ensure t)

;; C/C++ indentation.
(setq-default lsp-enable-indentation nil)
; (setq-default lsp-enable-snippet nil)
(setq-default c-basic-offset 4)
(setq-default c-default-style "linux")
(c-set-offset 'inline-open '0)

;; Use SLIME.
(use-package slime
	     :ensure t
	     :custom
	     (inferior-lisp-program "sbcl")
	     :config
	     (slime-setup))

;; Use flycheck.
; (require 'flycheck)
; (setq flycheck-clang-include-path (list "/usr/include"))
; (add-hook 'c++-mode-hook
;           (defun flycheck-change-checker-in-c++-hook ()
;             (flycheck-select-checker 'c/c++-gcc)))
; (global-flycheck-mode t)
; (setq-default flycheck-clang-language-standard "c++20")

; Use dashboard package. Better looking starting buffer.
(use-package dashboard
	     :ensure t
	     :config
	     (dashboard-setup-startup-hook))

;; Use company.
(use-package company
	     :ensure t
	     :hook ((after-init-hook . global-company-mode))
	     :custom
	     (company-clang-arguments (list "-std=c++20")))

;; Use auto-complete.
; (require 'auto-complete)
; (add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
; (ac-config-default)
; (ac-set-trigger-key "TAB")
; (ac-set-trigger-key "<tab>")
; (global-auto-complete-mode t)

;; Use modern C++ font.
(use-package modern-cpp-font-lock
	     :ensure t)

;; Use magit.
(use-package magit
	     :ensure t)

;; Autocomplete suggestions for "Find file". And probably more.
(use-package ido
	     :ensure
	     :config
             (ido-mode t))

;; Similar to IDO, but for M-x.
(use-package smex
	     :ensure t
	     :config
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
; That is old M-x command.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command))

;; Use YAsnippet.
(use-package yasnippet
	     :ensure t
	     :custom
    	     (yas-snippet-dirs '("~/.emacs.d/snippets"))
	     :config
	     (yas-global-mode 1))

;; Enable modus-vivendi theme.
(load-theme 'modus-vivendi t)

;; Autosave files are now in emacs_saves
(setq backup-directory-alist '(("." . "./.emacs_saves/")))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline success warning error])
 '(ansi-color-names-vector
   ["gray35" "#ff5f59" "#44bc44" "#d0bc00" "#2fafff" "#feacd0" "#00d3d0" "gray65"])
 '(chart-face-color-list
   '("#b52c2c" "#0fed00" "#f1e00a" "#2fafef" "#bf94fe" "#47dfea" "#702020" "#007800" "#b08940" "#1f2f8f" "#5f509f" "#00808f"))
 '(custom-enabled-themes '(modus-vivendi))
 '(custom-safe-themes
   '("69f7e8101867cfac410e88140f8c51b4433b93680901bb0b52014144366a08c8" modus-vivendi "44bb32e37eb2b0573021d5a0ddca17ec2ad437aec14d95fe96e59d1af06c044f" "ba4ab079778624e2eadbdc5d9345e6ada531dc3febeb24d257e6d31d5ed02577" "8d11daa5f67b21b377f159f12b47074e3dc706d03aa42dce90203f4516041448" default))
 '(exwm-floating-border-color "#646464")
 '(flymake-error-bitmap
   '(flymake-double-exclamation-mark modus-themes-prominent-error))
 '(flymake-note-bitmap '(exclamation-mark modus-themes-prominent-note))
 '(flymake-warning-bitmap '(exclamation-mark modus-themes-prominent-warning))
 '(frame-brackground-mode 'dark)
 '(highlight-changes-colors nil)
 '(highlight-changes-face-list '(success warning error bold bold-italic))
 '(hl-todo-keyword-faces
   '(("HOLD" . "#fec43f")
     ("TODO" . "#ff5f59")
     ("NEXT" . "#c6daff")
     ("THEM" . "#c6daff")
     ("PROG" . "#6ae4b9")
     ("OKAY" . "#6ae4b9")
     ("DONT" . "#fec43f")
     ("FAIL" . "#ff5f59")
     ("BUG" . "#ff5f59")
     ("DONE" . "#6ae4b9")
     ("NOTE" . "#fec43f")
     ("KLUDGE" . "#fec43f")
     ("HACK" . "#fec43f")
     ("TEMP" . "#fec43f")
     ("FIXME" . "#ff5f59")
     ("XXX+" . "#ff5f59")
     ("REVIEW" . "#6ae4b9")
     ("DEPRECATED" . "#6ae4b9")))
 '(ibuffer-deletion-face 'modus-themes-mark-del)
 '(ibuffer-filter-group-name-face 'bold)
 '(ibuffer-marked-face 'modus-themes-mark-sel)
 '(ibuffer-title-face 'default)
 '(ispell-dictionary nil)
 '(org-format-latex-options
   '(:foreground default :background default :scale 2.0 :html-foreground "Black" :html-background "Transparent" :html-scale 1.0 :matchers
                 ("begin" "$1" "$" "$$" "\\(" "\\[")))
 '(org-src-block-faces 'nil)
 '(package-selected-packages
   '(hindent haskell-emacs lsp-haskell exec-path-from-shell nim-mode pylint typescript-mode scribble-mode auctex org-fragtog flycheck-haskell vterm magit modern-cpp-font-lock auto-complete which-key sly fixmee todoist slime racket-mode haskell-mode sml-mode nasm-mode telega evil sr-speedbar rust-mode lsp-python-ms python-mode flycheck-cstyle flycheck-clang-analyzer ## flycheck-clangcheck yasnippet company-c-headers company lsp-ui lsp-mode cmake-mode solarized-theme smex gruber-darker-theme))
 '(pdf-view-midnight-colors '("#ffffff" . "#1e1e1e"))
 '(rcirc-colors
   '(modus-themes-fg-red modus-themes-fg-green modus-themes-fg-blue modus-themes-fg-yellow modus-themes-fg-magenta modus-themes-fg-cyan modus-themes-fg-red-warmer modus-themes-fg-green-warmer modus-themes-fg-blue-warmer modus-themes-fg-yellow-warmer modus-themes-fg-magenta-warmer modus-themes-fg-cyan-warmer modus-themes-fg-red-cooler modus-themes-fg-green-cooler modus-themes-fg-blue-cooler modus-themes-fg-yellow-cooler modus-themes-fg-magenta-cooler modus-themes-fg-cyan-cooler modus-themes-fg-red-faint modus-themes-fg-green-faint modus-themes-fg-blue-faint modus-themes-fg-yellow-faint modus-themes-fg-magenta-faint modus-themes-fg-cyan-faint modus-themes-fg-red-intense modus-themes-fg-green-intense modus-themes-fg-blue-intense modus-themes-fg-yellow-intense modus-themes-fg-magenta-intense modus-themes-fg-cyan-intense))
 '(safe-local-variable-values
   '((company-clang-arguments "-Iinclude")
     (eval setq flycheck-clang-include-path
           (list
            (expand-file-name "include/"))))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
