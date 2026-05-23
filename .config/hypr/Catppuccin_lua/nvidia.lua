hl.config({
    cursor = {
        no_hardware_cursors = true,
    },
    misc = {
        vrr = 0,
    },
    debug = {
        vfr = true,
    },
})

hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("__GL_GSYNC_ALLOWED", "1")
hl.env("__GL_MaxFramesAllowed", "1")
hl.env("WLR_USE_LIBINPUT", "1")
hl.env("LIBVA_DRIVERS_PATH", "/usr/lib/dri")
hl.env("GBM_BACKEND", "nvidia-drm")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("WLR_EGL_NO_MODIFIERS", "1")
hl.env("WLR_DRM_NO_ATOMIC", "1")
hl.env("NVD_BACKEND", "egl")

hl.on("hyprland.start", function()
    hl.exec_cmd("export HWDEC_DRIVER=$(~/.config/scripts/LibvaDriverName.sh)")
end)
