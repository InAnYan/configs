;; [[file:../emacs-init.org::*Personal constants][Personal constants:1]]
(defconst BIBLIOGRAPHY_FILES
  '("/mnt/data/library/clean/lit.bib"))

(defconst ORG_AGENDA_FILES
  '("/mnt/data/notes/calendar.org" "/mnt/data/notes/dump.org" "/mnt/data/notes/project-todos.org" "/mnt/data/notes/todos.org" "/mnt/data/notes/07_02_2025-university_2_kurs_2_semester.org"))

(defconst PROJECTS_DIR
  "/mnt/data/projects")

(defconst ORG_PROJECT_CAPTURE_FILE
  "/mnt/data/notes/project-todos.org")

(defconst MBSYNC_CONFIG_FILE
  "/mnt/data/mail/.mbsyncrc")

(defconst MAIL_DIR
  "/mnt/data/mail/")

(defconst MU_HOME
  "/mnt/data/mail/.muhome")

(defconst MU4E_LOAD_PATH
  "/usr/shar/emacs/site-lisp/mu4e")

(defconst SAVES_DIR
  "/mnt/data/misc/file-saves")

(defconst YAS_SNIPPET_DIR
  "/mnt/data/projects/yas-snippets")

(defconst MENTOR_HOME_DIR
  "/mnt/data/torrents/internal-rtorrent")

(defconst MENTOR_DOWNLOADS_DIR
  "/mnt/data/torrents/download")

(defconst MENTOR_EXTRA_CONF_FILE
  "/mnt/data/projects/configs/export/rtorrent.rc")

(defconst FEED_FILE
  "/mnt/data/projects/configs/feeds.org")

(defconst ORG_AUTOLOADS_DIR
  "/mnt/data/projects/org-mode/lisp")

(defconst ORG_ROAM_DIR
  "/mnt/data/notes")

(defconst ORG_FILES
  '( :todos "/mnt/data/notes/todos.org"
     :calendar "/mnt/data/notes/calendar.org"
     :dump "/mnt/data/notes/dump.org"))

;; Should be relative to =org-roam-directory= (which in my case is =ORG_ROAM_DIR=).
(defconst ORG_ROAM_DAILIES_DIR
  "journals/")

(defconst ORG_ATTACHMENTS_DIR
  "/mnt/data/notes/assets/")

(defconst DATE_FORMAT
  "%d.%m.%Y")

(defconst DATE_FORMAT_FOR_SAVE
  "%d_%m_%Y")

(defconst TIME_FORMAT
  "%H:%M")

(defconst TIME_FORMAT_FOR_SAVE
  "%H_%M")

(defconst DATE_TIME_FORMAT
  (concat DATE_FORMAT " " TIME_FORMAT))

(defconst DATE_TIME_FORMAT_FOR_SAVE
  (concat DATE_FORMAT_FOR_SAVE " " TIME_FORMAT_FOR_SAVE))
;; Personal constants:1 ends here

;; [[file:../emacs-init.org::*Additional: my signing key][Additional: my signing key:1]]
(setq mml-secure-openpgp-signers '("E48F78214714E2801A0499D82AADAC169FBAD443"))
;; Additional: my signing key:1 ends here

;; [[file:../emacs-init.org::*Global modes][Global modes:1]]
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

;; [[file:../emacs-init.org::*Main font][Main font:1]]
(set-face-attribute
 'default
 nil
 :font "JetBrainsMono Nerd Font Mono"
 :height 98
 :weight 'regular
 :slant 'normal
 :width 'normal)
;; Main font:1 ends here

;; [[file:../emacs-init.org::*Miscalleneous commands][Miscalleneous commands:1]]
(setq load-prefer-newer t)
(setq inhibit-startup-message t) ; Disable startup screen.
(setq mouse-autoselect-window t)
(setq focus-follows-mouse t)

(global-set-key (kbd "<escape>") 'keyboard-escape-quit) ; Make ESC quit prompts
(global-unset-key (kbd "C-z")) ; Little shit.
;; Miscalleneous commands:1 ends here

;; [[file:../emacs-init.org::*Easier window resizing][Easier window resizing:1]]
(global-set-key (kbd "<C-up>") 'shrink-window)
(global-set-key (kbd "<C-down>") 'enlarge-window)
(global-set-key (kbd "<C-left>") 'enlarge-window-horizontally)
(global-set-key (kbd "<C-right>") 'shrink-window-horizontally)
;; Easier window resizing:1 ends here

;; [[file:../emacs-init.org::*Use UTF-8 as much as possible][Use UTF-8 as much as possible:1]]
(set-charset-priority 'unicode)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(set-language-environment "UTF-8")
(prefer-coding-system 'utf-8)
(setq default-process-coding-system '(utf-8-unix . utf-8-unix))
;; Treat clipboard input as UTF-8 string first; compound text next, etc.
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))
;; Use UTF-8 as much as possible:1 ends here

;; [[file:../emacs-init.org::*Backups][Backups:1]]
(setq backup-directory-alist `(("." . ,SAVES_DIR)))
(setq backup-by-copying t)

(setq delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)
;; Backups:1 ends here

;; [[file:../emacs-init.org::*Misc][Misc:1]]
(setq-default user-mail-address "ruslanpopov1512@gmail.com")

(global-unset-key (kbd "C-x C-k"))
;; Misc:1 ends here

;; [[file:../emacs-init.org::*Utility functions][Utility functions:1]]
;; Easier syntax for running programs.
(defun iay/run-cmd (cmd)
  (start-process-shell-command cmd nil cmd))
;; Utility functions:1 ends here

;; [[file:../emacs-init.org::*Utility functions][Utility functions:2]]
(defun get-string-from-file (filePath)
  "Return file content as string."
  (with-temp-buffer
    (insert-file-contents filePath)
    (buffer-string)))
;; Utility functions:2 ends here

;; [[file:../emacs-init.org::*Eshell][Eshell:1]]
(defun iay/eshell-aliases ()
  (interactive)
  (shell-command "alias" "rm" "echo 'error: use `trash` instead of `rm`'"))

(add-hook 'eshell-mode-hook 'iay/eshell-aliases)
;; Eshell:1 ends here

;; [[file:../emacs-init.org::*=package=][=package=:1]]
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))
;; =package=:1 ends here

;; [[file:../emacs-init.org::*org autoload][org autoload:1]]
(add-to-list 'load-path ORG_AUTOLOADS_DIR)
;; org autoload:1 ends here

;; [[file:../emacs-init.org::*=use-package=][=use-package=:1]]
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)
;; =use-package=:1 ends here

;; [[file:../emacs-init.org::*Main theme][Main theme:1]]
(use-package modus-themes
  :config
  (load-theme 'modus-operandi t))
;; Main theme:1 ends here

;; [[file:../emacs-init.org::*Mode line][Mode line:1]]
(use-package mood-line
  :custom
  (mood-line-glyph-alist mood-line-glyphs-unicode)
  (mood-line-format mood-line-format-default-extended)

  :config
  (mood-line-mode))
;; Mode line:1 ends here

;; [[file:../emacs-init.org::*Paddings][Paddings:1]]
(use-package spacious-padding
  :custom
  (spacious-padding-widths
   '( :internal-border-width 15
      :header-line-width 4
      :mode-line-width 6
      :tab-width 4
      :right-divider-width 30
      :scroll-bar-width 8
      :fringe-width 8))
  (spacious-padding-subtle-mode-line
   `( :mode-line-active 'default
      :mode-line-inactive vertical-border))

  :config
  (spacious-padding-mode 1))
;; Paddings:1 ends here

;; [[file:../emacs-init.org::*Rainbow delimiters][Rainbow delimiters:1]]
(use-package rainbow-delimiters
  :hook
  (prog-mode . rainbow-delimiters-mode))
;; Rainbow delimiters:1 ends here

;; [[file:../emacs-init.org::*Icons][Icons:1]]
(use-package all-the-icons
  :config
  (set-fontset-font t 'unicode (font-spec :family "all-the-icons") nil 'append)
  (set-fontset-font t 'unicode (font-spec :family "file-icons") nil 'append)
  (set-fontset-font t 'unicode (font-spec :family "Material Icons") nil 'append)
  (set-fontset-font t 'unicode (font-spec :family "github-octicons") nil 'append)
  (set-fontset-font t 'unicode (font-spec :family "FontAwesome") nil 'append)
  (set-fontset-font t 'unicode (font-spec :family "Weather Icons") nil 'append))

(use-package all-the-icons-dired
  :hook
  (dired-mode . all-the-icons-dired-mode))
;; Icons:1 ends here

;; [[file:../emacs-init.org::*=dired=][=dired=:1]]
(setq dired-listing-switches "-agho --group-directories-first")
                                        ;(setf dired-kill-when-opening-new-dired-buffer t)
;; =dired=:1 ends here

;; [[file:../emacs-init.org::*=dired=][=dired=:2]]
;; IDK, why these 2 don't work.
;; (use-package dired)
;; (use-package dired-single)

;; (use-package dired-open
;;   :config
;;   (add-to-list 'dired-open-functions #'dired-open-xdg t))

;; (use-package dired-hide-dotfiles
;;   :hook
;;   (dired-mode . dired-hide-dotfiles-mode)

;;   :config
;;   (evil-define-key 'normal dired-mode-map "H" 'dired-hide-dotfiles-mode))
;; =dired=:2 ends here

;; [[file:../emacs-init.org::*Multi-term][Multi-term:1]]
(use-package multi-term
  :custom
  (multi-term-program "/bin/zsh"))
;; Multi-term:1 ends here

;; [[file:../emacs-init.org::*=doc-view=][=doc-view=:1]]
(setq doc-view-resolution 300)
;; =doc-view=:1 ends here

;; [[file:../emacs-init.org::*=pdf-tools=][=pdf-tools=:1]]
(use-package pdf-tools
  :config
  (pdf-loader-install))
;; =pdf-tools=:1 ends here

;; [[file:../emacs-init.org::*Email][Email:1]]
(use-package mu4e
  :ensure
  nil

  ;; :defer
  ;; 20

  :load-path
  MU4E_LOAD_PATH

  :custom
  (mu4e-change-filenames-when-moving t)
  (mu4e-update-interval (* 5 60)) ; Every 5 minutes.
  (mu4e-get-mail-command (format "mbsync -a --config %s" MBSYNC_CONFIG_FILE))
  (mu4e-maildir MAIL_DIR)
  (mu4e-mu-home MU_HOME)
  (mu4e-compose-format-flowed t)
  (message-send-mail-function 'message-send-mail-with-sendmail)
  (sendmail-program "/usr/bin/msmtp")
  (send-mail-function 'smtpmail-send-it)
  (message-sendmail-f-is-evil t)
  (message-sendmail-extra-arguments '("--read-envelope-from"))

  :config
  (require 'mu4e-org)
  (mu4e t)
  (setq mu4e-contexts
        (list
         (make-mu4e-context
          :name
          "gmail"

          :match-func
          (lambda (msg)
            (when msg
              (string-prefix-p "/gmail" (mu4e-message-field msg :maildir))))

          :vars `((user-mail-address . "ruslanpopov1512@gmail.com")
                  (user-full-name    . "Ruslan Popov")
                  (mu4e-drafts-folder  . "/gmail/[Gmail]/Drafts")
                  (mu4e-sent-folder  . "/gmail/[Gmail]/Sent Mail")
                  (mu4e-refile-folder  . "/gmail/[Gmail]/All Mail")
                  (mu4e-trash-folder  . "/gmail/[Gmail]/Trash")))
         (make-mu4e-context
          :name
          "new-uni"

          :match-func
          (lambda (msg)
            (when msg
              (string-prefix-p "/uni-new" (mu4e-message-field msg :maildir))))

          :vars `((user-mail-address . "popov_r@365.dnu.edu.ua")
                  (user-full-name    . "Ruslan Popov")
                  (mu4e-drafts-folder  . "/uni-new/Drafts")
                  (mu4e-sent-folder  . "/uni-new/Sent Items")
                  ;; (mu4e-refile-folder  . "/uni-new/inbox")
                  (mu4e-trash-folder  . "/uni-new/Trash")))
         (make-mu4e-context
          :name
          "old-uni"

          :match-func
          (lambda (msg)
            (when msg
              (string-prefix-p "/uni-old" (mu4e-message-field msg :maildir))))

          :vars `((user-mail-address . "popov_ro@ffeks.dnu.edu.ua")
                  (user-full-name    . "Ruslan Popov")
                  (mu4e-drafts-folder  . "/uni-old/Drafts")
                  (mu4e-sent-folder  . "/uni-old/Sent Items")
                  ;; (mu4e-refile-folder  . "/uni-old/inbox")
                  (mu4e-trash-folder  . "/uni-old/Trash"))))))
;; Email:1 ends here

;; [[file:../emacs-init.org::*Email][Email:2]]
(with-eval-after-load "mm-decode"
  (add-to-list 'mm-discouraged-alternatives "text/html")
  (add-to-list 'mm-discouraged-alternatives "text/richtext"))
;; Email:2 ends here

;; [[file:../emacs-init.org::*Email][Email:3]]
(use-package mu4e-alert
  :config
  (mu4e-alert-set-default-style 'notifications)
  (add-hook 'after-init-hook #'mu4e-alert-enable-notifications))
;; Email:3 ends here

;; [[file:../emacs-init.org::*Telegram][Telegram:1]]
(use-package telega
  :custom
  (telega-server-libs-prefix "/usr")

  :config
  (define-key global-map (kbd "C-c t") telega-prefix-map)
  (telega-notifications-mode 1))
;; Telegram:1 ends here

;; [[file:../emacs-init.org::*RSS/Atom][RSS/Atom:1]]
(use-package elfeed
  :bind
  ("C-x f" . elfeed)

  :custom
  (elfeed-search-filter "@6-months-ago")
  (elfeed-search-date-format `(,DATE_TIME_FORMAT 13 :left)))
;; RSS/Atom:1 ends here

;; [[file:../emacs-init.org::*RSS/Atom][RSS/Atom:3]]
(use-package elfeed-org
  :custom
  (rmh-elfeed-org-files (list FEED_FILE))

  :config
  (elfeed-org))
;; RSS/Atom:3 ends here

;; [[file:../emacs-init.org::*Torrent][Torrent:1]]
(use-package transmission)
;; Torrent:1 ends here

;; [[file:../emacs-init.org::*Copy/pasting][Copy/pasting:1]]
(use-package xclip
  :config
  (xclip-mode 1))
;; Copy/pasting:1 ends here

;; [[file:../emacs-init.org::*=ivy=][=ivy=:1]]
(use-package ivy
  :bind
  (:map ivy-minibuffer-map
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

  :custom
  (ivy-count-format "(%d/%d) ")
  (ivy-use-virtual-buffers t)

  :config
  (ivy-mode))
;; =ivy=:1 ends here

;; [[file:../emacs-init.org::*=ivy-rich=][=ivy-rich=:1]]
(use-package ivy-rich
  :config
  (ivy-rich-mode))

(setcdr (assq t ivy-format-functions-alist) #'ivy-format-function-line)
;; =ivy-rich=:1 ends here

;; [[file:../emacs-init.org::*=counsel=][=counsel=:1]]
(use-package counsel
  :after ivy

  :bind
  ("M-x" . counsel-M-x)
  ("C-x b" . counsel-ibuffer)
  ("C-x C-f" . counsel-find-file)

  :custom
  (ivy-initial-input-alist nil) ;; Don't start with ^. DOES NOT WORK

  :config
  (counsel-mode))
;; =counsel=:1 ends here

;; [[file:../emacs-init.org::*=prescient=][=prescient=:1]]
(use-package ivy-prescient
  :after
  counsel

  ;; :custom
  ;; (prescient-sort-length-enable nil)

  :config
  (ivy-prescient-mode 1))

(use-package company-prescient
  :after
  company

  :config
  (company-prescient-mode 1))

(prescient-persist-mode 1)
;; =prescient=:1 ends here

;; [[file:../emacs-init.org::*=swiper=][=swiper=:1]]
(use-package swiper
  :after ivy

  :bind
  ("C-s" . swiper)
  ("C-r" . swiper))
;; =swiper=:1 ends here

;; [[file:../emacs-init.org::*=smartparens=][=smartparens=:1]]
(use-package smartparens
  :config
  (require 'smartparens-config) ; Yes, not `use-package`.
  (smartparens-global-mode t))

;; Taken from: [[https://stackoverflow.com/a/35469843]].
(with-eval-after-load 'smartparens
  (sp-with-modes
      '(c++-mode objc-mode c-mode)
    (sp-local-pair "{" nil :post-handlers '(:add ("||\n[i]" "RET")))))
;; =smartparens=:1 ends here

;; [[file:../emacs-init.org::*Auto indent new lines][Auto indent new lines:1]]
(defun indent-between-pair (&rest _ignored)
  (newline)
  (indent-according-to-mode)
  (forward-line -1)
  (indent-according-to-mode))

(sp-local-pair 'prog-mode "{" nil :post-handlers '((indent-between-pair "RET")))
(sp-local-pair 'prog-mode "[" nil :post-handlers '((indent-between-pair "RET")))
(sp-local-pair 'prog-mode "(" nil :post-handlers '((indent-between-pair "RET")))
;; Auto indent new lines:1 ends here

;; [[file:../emacs-init.org::*=auctex= and general config][=auctex= and general config:1]]
(use-package auctex)

(setq-default TeX-brace-indent-level 4)
(setq-default LaTeX-indent-level 4)

(setq-default TeX-engine 'xetex)
(setq-default TeX-PDF-mode t)

(eval-after-load "tex"
  '(add-to-list
    'TeX-view-program-list
    '("preview-pane-mode"
      latex-preview-pane-mode)))
;; =auctex= and general config:1 ends here

;; [[file:../emacs-init.org::*=latex-preview-pane=][=latex-preview-pane=:1]]
(use-package latex-preview-pane
  :config
  (latex-preview-pane-enable))
;; =latex-preview-pane=:1 ends here

;; [[file:../emacs-init.org::*General config][General config:1]]
(setq org-export-with-toc nil)
(setq org-latex-title-command "\\maketitle")

(setq org-latex-compiler "xelatex")

                                        ; TODO: MOVE TO ORG.
;; (add-to-list 'org-latex-classes
;; 	     '("inanyan-paper"
;; 	       "\\documentclass{inanyan-paper}
;; 		[NO-DEFAULT-PACKAGES]
;; 		[NO-PACKAGES] "
;; 	       ("\\section{%s}" . "\\section*{%s}")
;; 	       ("\\subsection{%s}" . "\\subsection*{%s}")
;; 	       ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
;; 	       ("\\paragraph{%s}" . "\\paragraph*{%s}")
;; 	       ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

;; (add-to-list 'org-latex-classes
;; 	     '("inanyan-paper-new"
;; 	       "\\documentclass{inanyan-paper-new}
;; 		[NO-DEFAULT-PACKAGES]
;; 		[NO-PACKAGES] "
;; 	       ("\\section{%s}" . "\\section*{%s}")
;; 	       ("\\subsection{%s}" . "\\subsection*{%s}")
;; 	       ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
;; 	       ("\\paragraph{%s}" . "\\paragraph*{%s}")
;; 	       ("\\
;; subparagraph{%s}" . "\\subparagraph*{%s}")))
;; General config:1 ends here

;; [[file:../emacs-init.org::*=which-key=][=which-key=:1]]
(use-package which-key
  :custom
  (which-key-idle-delay 0.3)

  :config
  (which-key-mode))
;; =which-key=:1 ends here

;; [[file:../emacs-init.org::*=helpful=][=helpful=:1]]
(use-package helpful
  :commands
  (helpful-callable helpful-variable helpful-command helpful-key)

  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)

  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))
;; =helpful=:1 ends here

;; [[file:../emacs-init.org::*=org=][=org=:1]]
(use-package org
  :hook
  (org-mode . org-indent-mode)
  (org-mode . visual-line-mode)
  (org-babel-after-execute . org-link-preview-refresh)

  :bind
  ("C-c c" . org-capture)
  ("C-c a" . org-agenda)
  ("C-c l" . org-store-link)

  :custom
  (org-attach-id-dir ORG_ATTACHMENTS_DIR)
  (org-ellipsis " ▾")
  (org-startup-with-inline-images t)
  (org-todo-keywords '((sequence "TODO" "DOING" "|" "DONE" "NOTP")))
  (org-log-done t)
  (org-agenda-files ORG_AGENDA_FILES)
  (org-agenda-start-with-log-mode t)
  (org-log-into-drawer t)
  (org-auto-tangle-default t))

(advice-add 'org-refile :after 'org-save-all-org-buffers) ; As by default, when you refile, files are not saved.
;; =org=:1 ends here

;; [[file:../emacs-init.org::*=doct= and captures][=doct= and captures:1]]
(use-package doct)

(global-set-key (kbd "M-q") 'org-capture)

(setq
 org-capture-templates
 (doct `(( "TODO" :keys "t"
  	 :type entry
  	 :template "* TODO %?\n%U\n%a\n%i\n"
      	 :headline "Active"
      	 :empty-lines 1
  	 :file ,(plist-get ORG_FILES :todos))
       ( "Calendar entry" :keys "c"
  	 :type entry
  	 :template "* TODO %?\n%U\n%a\n%i\n"
      	 :headline "Active"
      	 :empty-lines 1
  	 :file ,(plist-get ORG_FILES :calendar))
       ( "Dump" :keys "d"
  	 :type entry
  	 :template "* %?\n%U\n%a\n%i\n"
      	 :headline "Active"
      	 :empty-lines 1
  	 :file ,(plist-get ORG_FILES :dump)))))
;; =doct= and captures:1 ends here

;; [[file:../emacs-init.org::*=org-babel=][=org-babel=:1]]
(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (python . t)))

(setq org-confirm-babel-evaluate nil)
;; =org-babel=:1 ends here

;; [[file:../emacs-init.org::*=org-autolist=][=org-autolist=:1]]
(use-package org-autolist
  :hook
  (org-mode . org-autolist-mode))
;; =org-autolist=:1 ends here

;; [[file:../emacs-init.org::*=org-bullets=][=org-bullets=:1]]
(use-package org-bullets
  :after org

  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))
;; =org-bullets=:1 ends here

;; [[file:../emacs-init.org::*=org-auto-tangle=][=org-auto-tangle=:1]]
(use-package org-auto-tangle
  :hook
  (org-mode . org-auto-tangle-mode))
;; =org-auto-tangle=:1 ends here

;; [[file:../emacs-init.org::*=org-appear=][=org-appear=:1]]
(use-package org-appear
  :hook
  (org-mode . org-appear-mode))
;; =org-appear=:1 ends here

;; [[file:../emacs-init.org::*=org-mime=][=org-mime=:1]]
(use-package org-mime
  ;; :hook
  ;; (message-send . org-mime-htmlize)
  :custom
  (org-mime-export-options '(:section-numbers nil :with-author nil :with-toc nil)))
;; =org-mime=:1 ends here

;; [[file:../emacs-init.org::*=org-roam=][=org-roam=:1]]
(use-package org-roam
  :custom
  (org-roam-directory ORG_ROAM_DIR)
  (org-roam-completion-everywhere t)

  (org-roam-dailies-capture-templates
   `(("d" "default" entry "* %?" :target
      (file+head ,(concat "%<" DATE_FORMAT_FOR_SAVE ">.org") ,(concat "#+TITLE: Journal for " DATE_FORMAT "\n\n")))))

  (org-roam-dailies-directory ORG_ROAM_DAILIES_DIR)

  (org-roam-capture-templates
   `(("d" "default" plain "%?" :target
      (file+head ,(concat "%<" DATE_FORMAT_FOR_SAVE ">-${slug}.org") "#+TITLE: ${title}\n\n")
      :unnarrowed t)))

  :bind (("C-c n l" . org-roam-buffer-toggle)
       ("C-c n f" . org-roam-node-find)
       ("C-c n i" . org-roam-node-insert)
       :map org-mode-map
       ("C-M-i"    . completion-at-point))
  :config
  (org-roam-setup))
;; =org-roam=:1 ends here

;; [[file:../emacs-init.org::*=org-notifications=][=org-notifications=:1]]
(use-package org-notifications)
;; =org-notifications=:1 ends here

;; [[file:../emacs-init.org::*GPTel][GPTel:1]]
(use-package gptel)

(gptel-make-ollama "Ollama"
  :host "localhost:11434"
  :stream t
  :models '(gemma2:2b-instruct-q4_K_M llama3.2:3b qwen2.5:3b qwen2.5:0.5b))
;; GPTel:1 ends here

;; [[file:../emacs-init.org::*Company][Company:1]]
(use-package company
  :custom
  (company-idle-delay 0.5)
  ;; (company-begin-commands nil) ;; uncomment to disable popup
  :bind
  (:map company-active-map
        ("C-j". company-select-next)
        ("C-k". company-select-previous)
        ("C-h". company-select-first)
        ("C-l". company-select-last)))
;; Company:1 ends here

;; [[file:../emacs-init.org::*Yasnippet][Yasnippet:1]]
(use-package yasnippet
  :hook
  (prog-mode . yas-minor-mode)
  (text-mode . yas-minor-mode)

  :custom
  (yas-snippet-dirs (list YAS_SNIPPET_DIR))

  :config
  (yas-reload-all))
;; Yasnippet:1 ends here

;; [[file:../emacs-init.org::*Flycheck][Flycheck:1]]
(use-package flycheck)
;; Flycheck:1 ends here

;; [[file:../emacs-init.org::*LSP][LSP:1]]
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

;; [[file:../emacs-init.org::*Projectile][Projectile:1]]
(use-package projectile
  :init
  (when (file-directory-p PROJECTS_DIR)
    (setq projectile-project-search-path (list PROJECTS_DIR)))
  (setq projectile-switch-project-action #'projectile-dired)

  :bind-keymap
  ("C-c p" . projectile-command-map)

  :custom
  (projectile-completion-system 'ivy)

  :config
  (projectile-mode))

(use-package counsel-projectile
  :after projectile

  :config
  (counsel-projectile-mode))

(use-package org-project-capture
  :bind
  (("C-c n p" . org-project-capture-project-todo-completing-read))

  :config
                                        ;(setq org-project-capture-backend
                                        ;      (make-instance 'org-project-capture-projectile-backend))
  (setq org-project-capture-projects-file ORG_PROJECT_CAPTURE_FILE)
  (org-project-capture-single-file))

(use-package org-projectile)
;; Projectile:1 ends here

;; [[file:../emacs-init.org::*Rust][Rust:1]]
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

;; [[file:../emacs-init.org::*YAML][YAML:1]]
(use-package yaml)
;; YAML:1 ends here

;; [[file:../emacs-init.org::*Python][Python:1]]
(use-package pyvenv)
;; Python:1 ends here

;; [[file:../emacs-init.org::*Miscalleneous packages][Miscalleneous packages:1]]
;; Log commands you typed.
(use-package command-log-mode)
;; Miscalleneous packages:1 ends here

;; [[file:../emacs-init.org::*Post-amble][Post-amble:1]]
(server-start)
;; Post-amble:1 ends here

;; [[file:../emacs-init.org::*Post-amble][Post-amble:2]]
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auth-source-save-behavior nil)
 '(custom-safe-themes
   '("fbf73690320aa26f8daffdd1210ef234ed1b0c59f3d001f342b9c0bbf49f531c" default))
 '(package-selected-packages
   '(doct latex-preview-pane auctex LaTeX visual-fill-column org-bullets evil-org evil-collection evil-leader key-chord evil general all-the-icons helpful ivy-rich which-key rainbow-delimiters rainbow-delimeters modus-themes desktop-environment exwm-systemtray exwm-randr exwm mood-line powerline citar counsel ivy command-log-mode))
 '(pdf-latex-command "xelatex"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;; Post-amble:2 ends here
