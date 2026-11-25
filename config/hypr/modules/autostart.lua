hl.on("hyprland.start", function()
	-- Wallpaper daemon (the helper below will start it again if it dies).
	hl.exec_cmd("awww-daemon")

	-- Restore the last wallpaper and regenerate the Matugen palette.
	hl.exec_cmd("~/.local/bin/wallpaper.sh init")

	-- Quickshell status bar + wallpaper picker (default config = ~/.config/quickshell/shell.qml).
	hl.exec_cmd("quickshell")

	-- Idle daemon.
	hl.exec_cmd("hypridle")

	-- Cursor theme/size (also exported in env.lua).
	hl.exec_cmd("hyprctl setcursor macOS 20")
end)
