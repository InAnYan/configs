set -e  # Exit on error


if [ "$(id -u)" -ne 0 ]; then
	echo "This script must be run as root."
	exit 1
fi

if [ "$#" -ne 13 ]; then
	echo "Usage: $0 <username> <user_password> <wifi_ssid> <wifi_password> <wifi_ip> <wifi_gateway> <wifi_dns_1> <wifi_dns_2> <custom_part> <custom_part_name> <ssh_conf_path> <git_email> <git_username>"
	exit 2
fi


username="$1"
password="$2"
wifi_ssid="$3"
wifi_password="$4"
wifi_ip="$5"
wifi_gateway="$6"
wifi_dns_1="$7"
wifi_dns_2="$8"
custom_part="$9"
custom_part_name="${10}"
ssh_conf_path="${11}"
git_email="${12}"
git_username="${13}"


NERD_FONT_LINK="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/JetBrainsMono.zip"
TEMP_DIR="temp"
OMZ_PLUGINS="git sudo zsh-autosuggestions web-search"


echo "Making temp dir..."

mkdir $TEMP_DIR

echo "[DONE] Making temp dir"


echo "Updating package list..."

pacman -Syu

echo "[DONE] Updating package list"


echo "Installing essential packages..."

pacman -Sy wget curl lynx vim sudo zsh firefox xorg xorg-server mate mate-extra network-manager network-manager-applet lightdm ttf-jetbrains-mono-nerd git 

tmux thunderbird  telegram-desktop nextcloud-client  docker docker-compose  discord i3 nodejs-lts-iron emacs keepassxc btop neofetch texlive pandoc gparted gh gcc lshw libreoffice-fresh flameshot qbittorrent base-devel

visual-studio-code-bin skypeforlinux-bin jabref gpt4all-chat logseq-desktop-bin

echo "[DONE] Installing essential packages"


echo "Enabling essential services..."

systemctl enable network-manager
systemctl enable lightdm

echo "[DONE] Enabling essential services"


echo "Creating main user..."

useradd -m -s /bin/zsh "$username"
echo "$username:$password" | chpasswd
usermod -aG wheel "$username"

echo "[DONE] Creating main user"


echo "Adding wheel to sudoers..."

echo "%wheel ALL=(ALL:ALL) ALL" >> /etc/sudoers

echo "[DONE] Adding wheel to sudoers"


echo "Setting up Wi-Fi..."

nmcli connection add type wifi con-name "Main Wi-Fi connection" ssid "$wifi_ssid" \
  wifi-sec.key-mgmt WPA-PSK wifi-sec.psk "$wifi_password" \
  ipv4.method manual ipv4.addresses "$wifi_ip"/24 ipv4.gateway "$wifi_gateway" \
  ipv4.dns "$wifi_dns_1 $wifi_dns_2" ipv6.method ignore
nmcli connection up "Main Wi-Fi connection"

echo "[DONE] Setting up Wi-Fi"


echo "Enabling click on touchpad..."

touchpad=$(xinput list | grep -i 'Touchpad' | awk -F'id=' '{print $2}' | awk '{print $1}')

if [ -n "$touchpad" ]; then
    xinput set-prop "$touchpad" "libinput Tapping Enabled" 1
    echo "Tap-to-click enabled on device ID $touchpad."
else
    echo "Touchpad not found."
fi

echo "[DONE] Enabling click on touchpad"


echo "Adding custom mount..."

mkdir /mnt/drive
mount "$custom_part" "/mnt/$custom_part_name"
chown -R "$username" "/mnt/$custom_part_name"

cp /etc/fstab /etc/fstab.bak
# Yeah, I use raw partition in `/dev`.
# And yes, default partition filesystem is ext4.
echo "$custom_part /mnt/$custom_part_name ext4 default 0 2" >> /etc/fstab

echo "[DONE] Adding custom mount"


echo "Copying SSH client configuration..."

cp "$ssh_conf_path/*" "/home/$username/.ssh/"

echo "[DONE] Copying SSH client configuration"


echo "Configuring Git..."

git config --global user.name "$git_username"
git config --global user.email "$git_email"

echo "[DONE] Configuring Git"


echo "Installing fonts..."

gsettings set org.mate.interface font-name 'JetBrainsMono Nerd Fonts Regular 6.5'
gsettings set org.mate.interface document-font-name 'JetBrainsMono Nerd Fonts Regular 6.5'
gsettings set org.mate.interface monospace-font-name 'JetBrainsMono Nerd Fonts Regular 8'
gsettings set org.mate.Marco.general titlebar-font 'JetBrainsMono Nerd Fonts Regular 6.5'
gsettings set org.mate.caja.desktop font 'JetBrainsMono Nerd Fonts Regular 6.5'

echo "[DONE] Installing fonts"


echo "Installing and configuring Oh-My-Zsh and theme..."

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
curl -sS https://starship.rs/install.sh | sh
echo "plugins=($OMZ_PLUGINS)" >> .zshrc
echo 'eval "$(starship init zsh)' >> .zshrc

echo "[DONE] Installing and configuring Oh-My-Zsh and theme"


echo "Removing temp dir..."

rm -rf $TEMP_DIR

echo "[DONE] Removing temp dir"

# TODO: YAY
# TODO: Add keyboard layouts.
# TODO: ESP-IDF.
# TODO: pipewire, pipewire-alsa, wireplumber, pipewire-pulse
#       systemctl --user --now enable pipewire pipewire-pulse wireplumber
# TODO: curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
# TODO: keyring
# TODO: ollama. + ollama model path
# TODO: gnome-keyring, libsecret

echo "-----------------------------------------------"
echo "DO THIS MANUALLY:"
echo "1. Log-in into Firefox account"
echo "2. Wait for install of every extension"
echo "3. Fix UI toolbar: remove spaces and always show bookmarks"
echo "4. Use light theme in Firefox"
echo "5. Configure ZSH"
echo "6. Configure Powerlevel 10k (*I forgot actual name*)"
echo "7. Log-in into personal Google account"
echo "8. Log-in into work Google account"
