;; [[file:../emacs-init-netbook.org::*Personal constants][Personal constants:1]]
(defconst SAVES_DIR
  "/mnt/data/misc/file-saves")
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
