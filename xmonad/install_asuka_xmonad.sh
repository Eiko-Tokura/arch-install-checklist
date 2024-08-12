mkdir ~/.xmonad

cp xmonad.hs ~/.xmonad/
cp -r lib ~/.xmonad/

cp xmobar/.xmobarrc ~/.xmobarrc
mkdir -p ~/.config/xmobar
cp xmobar/trayer-padding-icon.sh ~/.config/xmobar/trayer-padding-icon.sh

sudo pacman -S --needed git kitty alacritty dmenu trayer picom fcitx dunst redshift feh flameshot bluedevil maim slock pavucontrol arandr htop yazi stack sddm

cd ~/.xmonad
git clone https://github.com/xmonad/xmonad
git clone https://github.com/xmonad/xmonad-contrib

stack init
stack install
stack install xmobar

echo "[Desktop Entry]
Name=XMonad
Comment=Lightweight tiling window manager
Exec=/home/$USER/.local/bin/xmonad
Type=Application
" > xmonad.desktop

sudo cp xmonad.desktop /usr/share/xsessions/xmonad.desktop

sudo systemctl enable sddm

echo "Done! Please reboot your system. owo"
