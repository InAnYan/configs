top -bn 2 -d 0.01 | grep '^%Cpu.s' | tail -n 1 | gawk '{printf "%.1f", $2+$4+$6}'
