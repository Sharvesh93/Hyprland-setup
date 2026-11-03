hl.on("hyprland.start", function()
	-- Wallpaper daemon
	hl.exec_cmd("awww-daemon")
	-- Custom wallpaper & color theme initialization
	hl.exec_cmd("~/.local/bin/rice-theme.sh init")
	-- Minimalist Custom Quickshell desktop
	hl.exec_cmd("quickshell")
	-- Idle daemon & cursor
	hl.exec_cmd("hypridle")
	hl.exec_cmd("hyprctl setcursor macOS 20")
end)
