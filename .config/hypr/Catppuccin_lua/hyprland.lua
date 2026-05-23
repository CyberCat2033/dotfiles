local config_dir = os.getenv("HOME") .. "/.config/hypr/Catppuccin_lua/"

dofile(config_dir .. "base.lua")
dofile(config_dir .. "binds.lua")
dofile(config_dir .. "env.lua")
dofile(config_dir .. "autostart.lua")
dofile(config_dir .. "windowrules.lua")
-- dofile(config_dir .. "nvidia.lua")