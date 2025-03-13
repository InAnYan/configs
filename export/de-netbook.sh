# sh /mnt/data/projects/configs/export/lemonbar.sh | lemonbar -p &

export EDITOR="emacsclient --create-frame"

emacs --daemon &

eval $(ssh_agent)

picom &

polybar -c /mnt/data/projects/configs/export/polybar-netbook-config.ini &

flameshot &

sxhkd &

exec bspwm
