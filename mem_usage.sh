free | head -n 2 | tail -n 1 | gawk '{printf "%.1f", $3/$2*100}'
