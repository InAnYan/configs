;; [[file:../emacs-desktop.org::*Post-initialization of EXWM][Post-initialization of EXWM:1]]
(defun efs/run-in-background (command)
  (let ((command-parts (split-string command "[ ]+")))
    (apply #'call-process `(,(car command-parts) nil 0 nil ,@(cdr command-parts)))))

(defun iay/exwm-init-hook ()
  ;; Launch apps that will run in the background
  (efs/run-in-background "dunst")
  (efs/run-in-background "nm-applet")

  ;; No longer needed as I use =telega=.
  ;; (efs/run-in-background "telegram-desktop")

  (efs/run-in-background "skypeforlinux")
  (efs/run-in-background "flameshot")
  (efs/run-in-background "firefox")
  ;; (efs/run-in-background ".local/share/JetBrains/Toolbox/bin/jetbrains-toolbox")

  (exwm-workspace-switch-create 1)

  (eshell))
;; Post-initialization of EXWM:1 ends here

;; [[file:../emacs-desktop.org::*Correctly set up titles of X windows buffers][Correctly set up titles of X windows buffers:1]]
(defun efs/exwm-update-class ()
  (exwm-workspace-rename-buffer exwm-class-name))

(defun efs/exwm-update-title ()
  (pcase exwm-class-name
    ("Firefox" (exwm-workspace-rename-buffer (format "Firefox: %s" exwm-title)))))
;; Correctly set up titles of X windows buffers:1 ends here

;; [[file:../emacs-desktop.org::*Multi-display configuration][Multi-display configuration:1]]
(defun efs/update-displays ()
  (efs/run-in-background "autorandr --change --force")
  (message "Display config: %s"
           (string-trim (shell-command-to-string "autorandr --current"))))
;; Multi-display configuration:1 ends here

;; [[file:../emacs-desktop.org::*Bar set up][Bar set up:1]]
(defvar efs/polybar-process nil
  "Holds the process of the running Polybar instance, if any")

(defun efs/kill-panel ()
  (interactive)
  (when efs/polybar-process
    (ignore-errors
      (kill-process efs/polybar-process)))
  (setq efs/polybar-process nil))

(defun efs/start-panel ()
  (interactive)
  (efs/kill-panel)
  (setq efs/polybar-process (start-process-shell-command "polybar" nil "polybar")))

(defun efs/send-polybar-hook (module-name hook-index)
  (start-process-shell-command "polybar-msg" nil (format "polybar-msg hook %s %s" module-name hook-index)))

(defun efs/send-polybar-exwm-workspace ()
  (efs/send-polybar-hook "exwm-workspace" 1))
;; Bar set up:1 ends here

;; [[file:../emacs-desktop.org::*EXWM grand set up][EXWM grand set up:1]]
(use-package exwm
  :custom
  (exwm-workspace-number 5)
  (exwm-workspace-show-all-buffers t)
  (exwm-layout-show-all-buffers t)
  (exwm-workspace-warp-cursor t)
  (mouse-autoselect-window t)
  (focus-follows-mouse t)
  (exwm-input-global-keys
   `(([?\s-r] . exwm-reset) ;; s-r: Reset (to line-mode).
     ([?\s-w] . exwm-workspace-switch) ;; s-w: Switch workspace.
     ([?\s-&] . (lambda (cmd) ;; s-&: Launch application.
                  (interactive (list (read-shell-command "$ ")))
                  (iay/run-cmd cmd)))

     ;; Move between windows.
     ([s-h] . windmove-left)
     ([s-j] . windmove-down)
     ([s-k] . windmove-up)
     ([s-l] . windmove-right)

     ([?\s- ] . counsel-linux-app)

     ([?\s-i] . exwm-input-toggle-keyboard)

     ;; s-N: Switch to certain workspace.
     ,@(mapcar (lambda (i)
                 `(,(kbd (format "s-%d" i)) .
                   (lambda ()
                     (interactive)
                     (exwm-workspace-switch-create ,i))))
               (number-sequence 0 9))))
  (exwm-randr-workspace-monitor-plist
   '(0 "eDP-1" 1 "HDMI-1" 2 "HDMI-1" 3 "HDMI-1" 4 "HDMI-1" 5 "HDMI-1"))

  (exwm-input-prefix-keys
   [?\C-x
    ?\C-u
    ?\C-h
    ?\M-x
    ?\M-`
    ?\M-&
    ?\M-:
    ?\M-q ;; My org capture bindings.
    ?\C-\M-j  ;; Buffer list
    ?\C-\   ;; Ctrl+Space
    ?\C-\\
    ])
  :hook
  (exwm-init-hook . #'iay/exwm-init-hook)
  (exwm-update-class-hook . #'efs/exwm-update-class)
  (exwm-update-title-hook . #'efs/exwm-update-title)
  (exwm-workspace-switch-hook . #'efs/send-polybar-exwm-workspace)
  (exwm-randr-screen-change-hook .
                                 (lambda ()
                                   (start-process-shell-command
                                    "xrandr" nil
                                    (concat
                                     "xrandr --output eDP-1 --mode 1920x1080 --pos 0x0; "
                                     "xrandr --output HDMI-1 --mode 2560x1440 --pos 1920x0 --primary"))))
  :config
  (iay/run-cmd "xmodmap ~/.emacs.d/Xmodmap")
  (add-hook 'exwm-init-hook #'iay/exwm-init-hook)
  ;; NOTE: Uncomment these lines after setting up autorandr!
  ;; React to display connectivity changes, do initial display update
  (add-hook 'exwm-randr-screen-change-hook #'efs/update-displays)
  (add-hook 'exwm-workspace-switch-hook #'efs/send-polybar-exwm-workspace)
  (efs/update-displays)
  (exwm-enable)
  (exwm-randr-mode 1)
  (define-key exwm-mode-map [?\C-q] 'exwm-input-send-next-key) ; TODO: Move to :custom?
  ;; (exwm-input-set-key (kbd "s-SPC") 'counsel-linux-app) ; I don't understand why [?\s- ] doesn't work, however Emacs adviced it.

  (exwm-xim-mode 1)
  (push ?\C-\\ exwm-input-prefix-keys)
  )
;; EXWM grand set up:1 ends here

;; [[file:../emacs-desktop.org::*Add hook for updating buffer names][Add hook for updating buffer names:1]]
;; I have no fucking idea why this hook doesn't work in use-package.
(add-hook 'exwm-update-class-hook
          (lambda () (exwm-workspace-rename-buffer exwm-class-name)))
;; Add hook for updating buffer names:1 ends here

;; [[file:../emacs-desktop.org::*=desktop-environment= package][=desktop-environment= package:1]]
(use-package desktop-environment
  :after exwm
  :config
  (desktop-environment-mode))
;; =desktop-environment= package:1 ends here

;; [[file:../emacs-desktop.org::*Postamble][Postamble:1]]
(exwm-init)
;; Postamble:1 ends here
