local mainMod = "SUPER"
local terminal = "kitty"
local scripts_dir = "~/.config/scripts"
local fileManager = "env EDITOR=nvim kitty --class yazi yazi"
local OCR4Linux = "~/.config/OCR4Linux/OCR4Linux.sh"

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace",
})

hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("pkill rofi || ~/.config/hypr/Catppuccin_lua/rofi/launchers/type-6/launcher.sh"))
hl.bind(mainMod .. " + H", hl.dsp.exec_cmd("hyprlock -c ~/.config/hypr/Catppuccin_lua/hyprlock/hyprlock.conf"))
hl.bind(mainMod .. " + SHIFT + A", hl.dsp.exec_cmd("kitty anicli-ru cli -s animego"))
hl.bind("ALT + Tab", hl.dsp.window.cycle_next(), { locked = true, repeating = true })
hl.bind("ALT + Tab", hl.dsp.window.bring_to_top(), { locked = true, repeating = true })
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd("kitty --class bluetooth bluetuith"))
hl.bind(mainMod .. " + SHIFT + V", hl.dsp.exec_cmd("code"))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.exec_cmd("firefox"))
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.exec_cmd(scripts_dir .. "/WallpaperResumePause.sh"))
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind("Print", hl.dsp.exec_cmd("grim -g \"$(slurp)\" - | swappy -f -"))
hl.bind(mainMod .. " + G", hl.dsp.exec_cmd("~/.config/scripts/gamemode.sh"))
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("killall -SIGUSR2 waybar || waybar -c ~/.config/hypr/Catppuccin_lua/waybar/config.jsonc -s ~/.config/hypr/Catppuccin_lua/waybar/style.css"))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("killall -SIGUSR1 waybar"))
hl.bind("switch:Lid Switch", hl.dsp.exec_cmd("hyprlock -c ~/.config/hypr/Catppuccin_lua/hyprlock/hyprlock.conf & systemctl suspend || loginctl suspend"), { locked = true })
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + T", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd("kitty --class pulsemixer pulsemixer"))
hl.bind(mainMod .. " + SHIFT + T", hl.dsp.exec_cmd("Telegram"))
hl.bind(mainMod .. " + CTRL + P", hl.dsp.exec_cmd("~/.config/hypr/Catppuccin_lua/rofi/powermenu/type-4/powermenu.sh"))
hl.bind(mainMod .. " + SHIFT + M", function()
    hl.dispatch(hl.dsp.window.tag({ tag = "movie" }))
    hl.dispatch(hl.dsp.exec_cmd(scripts_dir .. "/movie_mode.sh"))
end)
hl.bind(mainMod .. " + SHIFT + O", hl.dsp.exec_cmd(OCR4Linux .. " -r --lang eng+rus"))

hl.bind(mainMod .. " + equal", hl.dsp.exec_cmd("hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor -j | jq '.float * 1.4')"), { repeating = true })
hl.bind(mainMod .. " + minus", hl.dsp.exec_cmd("hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor -j | jq '(.float * 0.6) | if . < 1 then 1 else . end')"), { repeating = true })

hl.bind("ALT + CTRL + up", hl.dsp.exec_cmd("ddcutil --sleep-multiplier=0.1 setvcp 10 + 10 && " .. scripts_dir .. "/brightnes_ddcutil.sh"), { locked = true, repeating = true })
hl.bind("ALT + CTRL + down", hl.dsp.exec_cmd("ddcutil --sleep-multiplier=0.005 setvcp 10 - 10 && " .. scripts_dir .. "/brightnes_ddcutil.sh"), { locked = true, repeating = true })
hl.bind("XF86Tools", hl.dsp.exec_cmd(scripts_dir .. "/mediaplayer.sh"))
hl.bind("XF86Calculator", hl.dsp.exec_cmd("qalculate-gtk"))
hl.bind("XF86ScreenSaver", hl.dsp.exec_cmd("hyprlock -c ~/.config/hypr/Catppuccin_lua/hyprlock/hyprlock.conf"))
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set 10%+ && " .. scripts_dir .. "/brightnes.sh"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 10%- && " .. scripts_dir .. "/brightnes.sh"), { locked = true, repeating = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause && " .. scripts_dir .. "/playerctl_album.sh"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause && " .. scripts_dir .. "/playerctl_album.sh"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous && " .. scripts_dir .. "/playerctl_album.sh"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next && " .. scripts_dir .. "/playerctl_album.sh"), { locked = true })
hl.bind("XF86AudioStop", hl.dsp.exec_cmd("playerctl stop && " .. scripts_dir .. "/playerctl_album.sh"), { locked = true })
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ -l 1.5 && " .. scripts_dir .. "/sound.sh"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- -l 1.5 && " .. scripts_dir .. "/sound.sh"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(scripts_dir .. "/mute.sh"), { locked = true })

hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + left", hl.dsp.window.bring_to_top())
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + right", hl.dsp.window.bring_to_top())
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + up", hl.dsp.window.bring_to_top())
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + down", hl.dsp.window.bring_to_top())

for i = 1, 9 do
    hl.bind(mainMod .. " + " .. i, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end
hl.bind(mainMod .. " + 0", hl.dsp.focus({ workspace = 10 }))
hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(scripts_dir .. "/resize.sh \"Resize mode activated\""))
hl.bind(mainMod .. " + R", hl.dsp.submap("resize"))

hl.define_submap("resize", function()
    hl.bind("right", hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })
    hl.bind("left", hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true })
    hl.bind("up", hl.dsp.window.resize({ x = 0, y = -10, relative = true }), { repeating = true })
    hl.bind("down", hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })
    hl.bind("escape", hl.dsp.exec_cmd(scripts_dir .. "/resize.sh \"Resize mode deactivated\""))
    hl.bind("catchall", hl.dsp.exec_cmd(scripts_dir .. "/resize.sh \"Resize mode is active\""))
    hl.bind("escape", hl.dsp.submap("reset"))
end)

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
