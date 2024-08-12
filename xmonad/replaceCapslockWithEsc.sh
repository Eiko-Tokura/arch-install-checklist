echo "[Unit]
Description=Load custom keymap, replacing capslock with escape

[Service]
Type=oneshot
ExecStart=/usr/bin/loadkeys /usr/share/kbd/keymaps/i386/include/linux-with-caps-esc.inc

[Install]
WantedBy=multi-user.target" > custom-keymap.service

echo "include \"linux-keys-bare.inc\"

keycode 58 = Escape" > linux-with-caps-esc.inc

sudo mv custom-keymap.service /etc/systemd/system/
sudo mv linux-with-caps-esc.inc /usr/share/kbd/keymaps/i386/include/
sudo systemctl enable custom-keymap.service --now

echo "Replaced capslock with escape, reboot to apply changes"
