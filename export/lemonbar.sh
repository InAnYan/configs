while true; do
    echo -n '%{l}'
    echo -n $(bspc query -D -d focused --names)
    echo -n '%{c}'
    echo -n $(date '+%H:%M:%S')
    echo -n '%{r}'
    echo -n 'C'
    echo -n $(sh /mnt/data/projects/configs/cpu_usage.sh)%
    echo -n ' '
    echo -n 'M'
    echo -n $(sh /mnt/data/projects/configs/mem_usage.sh)%
    echo -n ' '
    echo -n 'B'
    echo -n $(cat /sys/class/power_supply/BAT0/capacity)%
    echo -n ' '
    echo -n $(date '+%d.%m.%Y')
    echo
done
