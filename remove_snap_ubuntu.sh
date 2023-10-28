# Source: https://web.archive.org/web/20200424210525/https://www.kevin-custer.com/blog/disabling-snaps-in-ubuntu-20-04/

snap list | tail -n +2 | \
while read i
do
	arr=($i)
	sudo snap remove ${arr[0]}
done

echo "NOTE: Probably, you should rerun the script several times in order to remove all snap packages. They are removed not in the dependency order."

# sudo umount /snap/core ???

sudo apt purge snapd

rm -rf ~/snap
sudo rm -rf /snap
sudo rm -rf /var/snap
sudo rm -rf /var/lib/snapd

