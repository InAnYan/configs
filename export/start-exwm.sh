# [[file:../emacs-start-exwm.org::*Set up XIM][Set up XIM:1]]
export XMODIFIERS=@im=exwm-xim
export GTK_IM_MODULE=xim
export QT_IM_MODULE=xim
export CLUTTER_IM_MODULE=xim
# Set up XIM:1 ends here

# [[file:../emacs-start-exwm.org::*Screen compositor][Screen compositor:1]]
picom &
# Screen compositor:1 ends here

# [[file:../emacs-start-exwm.org::*Some =polybar= set up][Some =polybar= set up:1]]
for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload iay &
done
# Some =polybar= set up:1 ends here

# [[file:../emacs-start-exwm.org::*SSH agent][SSH agent:1]]
eval $(ssh-agent)
# SSH agent:1 ends here

# [[file:../emacs-start-exwm.org::*Fire-up Emacs][Fire-up Emacs:1]]
exec dbus-launch emacs -mm --debug-init -l /home/ruslan/.emacs.d/desktop.el
# Fire-up Emacs:1 ends here
