hl.monitor({
    output = "",
    mode = "highres",
    position = "auto-right",
    scale = 1,
})

hl.monitor({
    output = "eDP-1",
    mode = "preferred",
    position = "1920x0",
    scale = 1,
})

hl.device({
    name = "msft0001:00-04f3:31dd-touchpad",
    sensitivity = -0.09,
})

hl.device({
    name = "elan-touchpad",
    sensitivity = 0.42,
})

hl.device({
    name = "elan06fa:00-04f3:31dd-touchpad",
    sensitivity = 0.42,
})

hl.config({
    xwayland = {
        force_zero_scaling = true,
    },
    ecosystem = {
        no_update_news = true,
    },
    debug = {
        vfr = true,
    },
    misc = {
        animate_manual_resizes = true,
        mouse_move_focuses_monitor = true,
        enable_swallow = true,
        swallow_regex = "^(kitty|Alacritty)$",
        swallow_exception_regex = "^(yazi|bluetuith|pulsemixer|nmwui)$",
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        mouse_move_enables_dpms = true,
        force_default_wallpaper = 0,
    },
    input = {
        kb_layout = "us,ru",
        kb_variant = "",
        kb_model = "",
        kb_options = "grp:caps_toggle,compose:ralt",
        kb_rules = "",
        scroll_factor = 1.0,
        follow_mouse = 1,
        sensitivity = 0,
        touchpad = {
            natural_scroll = false,
            scroll_factor = 0.6,
        },
    },
    general = {
        gaps_in = 4,
        gaps_out = 12,
        border_size = 2,
        col = {
            active_border = { colors = { "rgba(f2cdcdee)", "rgba(f5e0dcee)" }, angle = 45 },
            inactive_border = "rgba(1e1e2eff)",
        },
        resize_on_border = false,
        allow_tearing = false,
        layout = "dwindle",
    },
    decoration = {
        rounding = 10,
        active_opacity = 1.0,
        inactive_opacity = 1.0,
        blur = {
            enabled = true,
            size = 6,
            passes = 1,
            xray = true,
            ignore_opacity = true,
            vibrancy = 0.1696,
        },
    },
    animations = {
        enabled = true,
    },
    dwindle = {
        preserve_split = true,
    },
    master = {
        new_status = "master",
    },
})

hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("md3_standard", { type = "bezier", points = { { 0.2, 0 }, { 0, 1 } } })
hl.curve("md3_decel", { type = "bezier", points = { { 0.15, 0.7 }, { 0.1, 1 } } })
hl.curve("md3_accel", { type = "bezier", points = { { 0.3, 0 }, { 0.8, 0.15 } } })
hl.curve("overshot", { type = "bezier", points = { { 0.15, 0.9 }, { 0.1, 1.1 } } })
hl.curve("crazyshot", { type = "bezier", points = { { 0.1, 1.5 }, { 0.76, 0.92 } } })
hl.curve("hyprnostretch", { type = "bezier", points = { { 0.15, 0.9 }, { 0.1, 1.0 } } })
hl.curve("menu_decel", { type = "bezier", points = { { 0.1, 1 }, { 0, 1 } } })
hl.curve("menu_accel", { type = "bezier", points = { { 0.38, 0.04 }, { 1, 0.07 } } })
hl.curve("easeInOutCirc", { type = "bezier", points = { { 0.85, 0 }, { 0.15, 1 } } })
hl.curve("easeOutCirc", { type = "bezier", points = { { 0, 0.55 }, { 0.45, 1 } } })
hl.curve("easeOutExpo", { type = "bezier", points = { { 0.16, 1 }, { 0.3, 1 } } })
hl.curve("softAcDecel", { type = "bezier", points = { { 0.26, 0.26 }, { 0.15, 1 } } })
hl.curve("md2", { type = "bezier", points = { { 0.4, 0 }, { 0.2, 1 } } })

hl.animation({ leaf = "windows", enabled = true, speed = 3, bezier = "md3_decel", style = "popin 60%" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 3, bezier = "md3_decel", style = "popin 60%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 3, bezier = "md3_accel", style = "popin 60%" })
hl.animation({ leaf = "border", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "fade", enabled = true, speed = 3, bezier = "md3_decel" })
hl.animation({ leaf = "layers", enabled = true, speed = 2, bezier = "md3_decel", style = "slide" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 3, bezier = "menu_decel", style = "slide" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.6, bezier = "menu_accel" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 2, bezier = "menu_decel" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 4.5, bezier = "menu_accel" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 2.5, bezier = "softAcDecel", style = "slide" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 3, bezier = "md3_decel", style = "slidevert" })
