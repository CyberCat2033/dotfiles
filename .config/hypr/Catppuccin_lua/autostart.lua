hl.on("hyprland.start", function()
	hl.exec_cmd("~/.config/scripts/StartupWallpaper.sh")
	hl.exec_cmd(
		"waybar -c ~/.config/hypr/Catppuccin_lua/waybar/config.jsonc -s ~/.config/hypr/Catppuccin_lua/waybar/style.css"
	)
	hl.exec_cmd("mako -c ~/.config/hypr/Catppuccin_lua/mako/config")
	hl.exec_cmd("systemctl --user start hyprpolkitagent")
	hl.exec_cmd("brightnessctl set 100%")
	hl.exec_cmd([[sh -c 'sleep 2; hyprctl dispatch exec "[workspace 1 silent] firefox"']])
	hl.exec_cmd([[sh -c 'sleep 3; otd-daemon']])
	hl.exec_cmd([[sh -c 'sleep 4; koala-clash']])
	hl.exec_cmd([[sh -c 'sleep 5; Telegram -startintray']])
	hl.exec_cmd(
		[[sh -c 'sleep 6; ~/.config/scripts/bins/image_processor || notify-send -i "/usr/share/icons/Tela-circle-black/scalable/apps/script-error.svg" --hint=int:transient:1 --expire-time=40000 --hint=string:x-canonical-private-synchronous:9999 -u critical "Error" "image_processor exited with error"']]
	)
	hl.exec_cmd("gsettings set org.gnome.desktop.interface gtk-theme 'catppuccin-mocha-maroon-standard+default'")
	hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-theme 'Catppuccin-Mocha-Maroon-Cursors'")
	hl.exec_cmd("gsettings set org.gnome.desktop.interface icon-theme Tela-circle-black")
	hl.exec_cmd("hyprctl setcursor Catppuccin-Mocha-Maroon-Cursors 24")
end)
