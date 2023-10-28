# Source: https://askubuntu.com/questions/1399383/how-to-install-firefox-as-a-traditional-deb-package-without-snap-in-ubuntu-22/

sudo add-apt-repository ppa:mozillateam/ppa

sudo systemctl stop var-snap-firefox-common-host\\x2dhunspell.mount
sudo systemctl disable var-snap-firefox-common-host\\x2dhunspell.mount

echo '
Package: *
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 1001

Package: firefox
Pin: version 1:1snap1-0ubuntu2
Pin-Priority: -1
' | sudo tee /etc/apt/preferences.d/mozilla-firefox

sudo apt install firefox

echo 'Unattended-Upgrade::Allowed-Origins:: "LP-PPA-mozillateam:${distro_codename}";' | sudo tee /etc/apt/apt.conf.d/51unattended-upgrades-firefox
