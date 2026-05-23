local function workspace(workspace_name, monitor_name)
	hl.workspace_rule({
		workspace = workspace_name,
		monitor = monitor_name,
	})
end

local function rule(spec)
	hl.window_rule(spec)
end

local function size_percent(width, height)
	return { "monitor_w*" .. width, "monitor_h*" .. height }
end

local function pos_percent(x, y)
	return { "monitor_w*" .. x, "monitor_h*" .. y }
end

workspace("2", "HDMI-A-1")
workspace("4", "HDMI-A-1")
workspace("6", "HDMI-A-1")
workspace("8", "HDMI-A-1")
workspace("1", "eDP-1")
workspace("3", "eDP-1")
workspace("5", "eDP-1")
workspace("7", "eDP-1")
workspace("9", "eDP-1")

hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 1, gaps_in = 0 })
hl.workspace_rule({ workspace = "f[1]", gaps_out = 1, gaps_in = 0 })
rule({ match = { float = false, workspace = "w[tv1]" }, border_size = 1, rounding = 7 })
rule({ match = { float = false, workspace = "f[1]" }, border_size = 1, rounding = 7 })

-- Telegram rules
rule({
	match = { class = "org.telegram.desktop" },
	float = true,
	size = { 420, 700 },
	opacity = "0.92",
	pin = true,
	move = pos_percent("0.775", "0.337"),
})
rule({
	match = { class = "telegram-desktop", title = "^(.*Choose.*)$" },
	float = true,
	size = { 900, 600 },
	opacity = "0.94",
})
rule({
	match = { class = "telegram-desktop", title = "^(.*Save.*)$" },
	float = true,
	size = { 900, 600 },
	opacity = "0.94",
})

-- NMWUI rules
rule({ match = { class = "^(nmwui)$" }, stay_focused = true, float = true, size = { 800, 600 }, pin = true })

-- General opacity rules
rule({ match = { class = "^(cmus)$" }, opacity = "0.97" })
rule({ match = { class = "kitty" }, opacity = "0.97" })
rule({ match = { class = "firefox" }, opacity = "0.96" })
rule({ match = { class = "^(Code)$" }, opacity = "0.96" })
rule({ match = { class = "^(far2l)$" }, opacity = "0.95" })

-- Bluetooth rules
rule({ match = { class = "^(bluetooth)$" }, stay_focused = true, float = true, size = { 1000, 500 }, pin = true })

-- Firefox Library rules
rule({
	match = { title = "^(Library)$" },
	float = true,
	size = size_percent("0.3", "0.3"),
	center = true,
	opacity = "0.82",
})

-- Picture-in-Picture rules
rule({ match = { title = "^(Picture-in-Picture)$" }, float = true })
rule({
	match = { class = "(firefox)", title = "^(Picture-in-Picture)$" },
	float = true,
	size = size_percent("0.3", "0.3"),
	pin = true,
	move = pos_percent("0.698", "0.695"),
	opacity = "1",
})
rule({ match = { title = "^(Sign)$" }, float = true })

-- Krita dialogs
rule({
	match = { class = "(krita)", title = "^(.*Open.*)$" },
	float = true,
	size = size_percent("0.4", "0.4"),
	center = true,
})
rule({
	match = { class = "(krita)", title = "^(.*Sav.*)$" },
	float = true,
	size = size_percent("0.4", "0.4"),
	center = true,
})
rule({
	match = { class = "(krita)", title = "^(.*Export.*)$" },
	float = true,
	size = size_percent("0.4", "0.4"),
	center = true,
})
rule({
	match = { class = "(krita)", title = "^(.*Sessions.*)$" },
	float = true,
	size = size_percent("0.4", "0.4"),
	center = true,
})
rule({
	match = { class = "(krita)", title = "^(.*Import.*)$" },
	float = true,
	size = size_percent("0.4", "0.4"),
	center = true,
})

-- Video rules
rule({ match = { title = "^(.*YouTube.*)$" }, opacity = "1.0 1.0 override" })
rule({ match = { fullscreen = true, title = "^(.*YouTube.*)$" }, opacity = "1.0 override" })
rule({ match = { class = "^(vlc)" }, opacity = "1.0" })
rule({ match = { title = "^(.*anime.*)$" }, opacity = "1.0 1.0" })
rule({ match = { fullscreen = true, title = "^(.*anime.*)$" }, opacity = "1.0 override" })

-- Terminal file managers
rule({ match = { class = "^(ranger)$" }, opacity = "0.97" })
rule({ match = { class = "^(yazi)$" }, opacity = "0.97" })

-- PulseMixer rules
rule({
	match = { class = "^(pulsemixer)$" },
	stay_focused = true,
	float = true,
	size = { 1000, 500 },
	pin = true,
	opacity = "0.89",
})
rule({ match = { tag = "movie" }, opacity = "1" })

-- File managers and image viewers
rule({ match = { class = "^(nemo)$" }, float = true, opacity = "0.94", size = { 1000, 600 } })
rule({ match = { class = "^(org.gnome.FileRoller)$" }, float = true })
rule({ match = { class = "viewnior" }, float = true, size = { 800, 450 }, center = true })
rule({ match = { class = "^(swayimg)$" }, float = true, size = { 800, 450 }, center = true })

-- App dialogs
rule({ match = { class = "^(lutris)$" }, size = { 900, 600 }, float = true, center = true })
rule({ match = { class = "^(Rofi)$" }, float = true, stay_focused = true, pin = true, opacity = "0.96" })
rule({ match = { class = "^(clash-verge)$" }, float = true, size = { 500, 600 }, center = true })
rule({ match = { class = "^(hiddify)$" }, float = true, size = { 450, 800 }, center = true })
rule({ match = { class = "^(qalculate-gtk)$" }, float = true })
rule({ match = { class = "^(gnuplot_qt)$" }, float = true, size = { 800, 700 } })
rule({ match = { class = "^(org.kde.polkit-kde-authentication-agent-1)$" }, float = true })
rule({ match = { class = "^(pavucontrol)$" }, float = true })
rule({ match = { title = "^(DevTools)$" }, float = true })
rule({ match = { class = "^(file_progress)$" }, float = true })
rule({ match = { class = "^(confirm)$" }, float = true })
rule({ match = { class = "^(dialog)$" }, float = true })
rule({ match = { class = "^(download)$" }, float = true })
rule({ match = { class = "^(notification)$" }, float = true })
rule({ match = { class = "^(error)$" }, float = true })
rule({ match = { class = "^(confirmreset)$" }, float = true })
rule({ match = { title = "^(Open File)$" }, float = true, size = { 800, 600 } })
rule({ match = { title = "^(Save File)$" }, size = { 800, 600 } })
rule({ match = { title = "^(branchdialog)$" }, float = true })
rule({ match = { title = "^(Confirm to replace files)" }, float = true })
rule({ match = { title = "^(File Operation Progress)" }, float = true })

-- Winboat rules
rule({
	match = { class = "^winboat-.*$" },
	workspace = "1",
	suppress_event = "fullscreen maximize activate activatefocus",
	no_initial_focus = true,
	fullscreen = true,
})
rule({
	match = { class = "^winboat-.*$" },
	no_anim = true,
	rounding = 0,
	no_shadow = true,
	no_blur = true,
	xray = false,
	opaque = true,
	no_dim = true,
})
rule({ match = { xwayland = true, class = "negative:^winboat-.*$" }, force_rgbx = true })
