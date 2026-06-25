-- terminal, fileManager, browser, mainMod are globals defined in hyprland.lua
local home = os.getenv("HOME")

-- Apps
hl.bind(mainMod .. " + RETURN",       hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Q",            hl.dsp.window.close())
hl.bind(mainMod .. " + M",            hl.dsp.exit())
hl.bind(mainMod .. " + E",            hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V",            hl.dsp.exec_cmd(home .. "/.config/hypr/scripts/toggle_floating.sh"))
hl.bind(mainMod .. " + F",            hl.dsp.window.fullscreen())
hl.bind("F11",                        hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + period",       hl.dsp.exec_cmd("emote"))
hl.bind(mainMod .. " + J",            hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + I",            hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + SHIFT + R",    hl.dsp.exec_cmd("hyprctl reload"))

-- DMS (Dank Material Shell)
hl.bind(mainMod .. " + space",        hl.dsp.exec_cmd("dms ipc call spotlight toggle"))
hl.bind(mainMod .. " + C",            hl.dsp.exec_cmd("dms ipc call clipboard toggle"))
hl.bind(mainMod .. " + SHIFT + N",    hl.dsp.exec_cmd("dms ipc call notifications toggle"))
hl.bind(mainMod .. " + X",            hl.dsp.exec_cmd("dms ipc call powermenu toggle"))
hl.bind(mainMod .. " + D",            hl.dsp.exec_cmd("dms ipc call dash toggle media"))
hl.bind(mainMod .. " + O",            hl.dsp.exec_cmd("dms ipc call dash toggle calendar"))
hl.bind(mainMod .. " + L",            hl.dsp.exec_cmd("dms ipc call lock lock"))
hl.bind(mainMod .. " + W",            hl.dsp.exec_cmd("dms ipc call bar toggle index 0"))

-- Screenshots
hl.bind("Print",                      hl.dsp.exec_cmd("grim - | wl-copy --type image/png"))
hl.bind(mainMod .. " + CTRL + S",     hl.dsp.exec_cmd('grim -g "$(slurp)" ' .. home .. '/Pictures/Screenshot_$(date +%Y%m%d_%H%M%S).png'))
hl.bind(mainMod .. " + SHIFT + S",    hl.dsp.exec_cmd('grim -g "$(slurp)" - | wl-copy'))

-- Focus
hl.bind(mainMod .. " + left",         hl.dsp.focus({ direction = "left"  }))
hl.bind(mainMod .. " + right",        hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",           hl.dsp.focus({ direction = "up"    }))
hl.bind(mainMod .. " + down",         hl.dsp.focus({ direction = "down"  }))

-- Workspaces
for i = 1, 10 do
  local key = i % 10
  hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
  hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end
hl.bind("ALT + Tab",                  hl.dsp.focus({ workspace = "previous" }))
hl.bind(mainMod .. " + Tab",         hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_down",  hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",    hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize with mouse
hl.bind(mainMod .. " + mouse:272",   hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273",   hl.dsp.window.resize(), { mouse = true })

-- Resize with keyboard
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.exec_cmd("hyprctl dispatch resizeactive 50 0"))
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.exec_cmd("hyprctl dispatch resizeactive -50 0"))
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.exec_cmd("hyprctl dispatch resizeactive 0 -50"))
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.exec_cmd("hyprctl dispatch resizeactive 0 50"))

-- Audio
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),  { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),        { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),       { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),     { locked = true, repeating = true })

-- Brightness (via DMS)
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("dms ipc call brightness decrement 5 backlight:intel_backlight"), { locked = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("dms ipc call brightness increment 5 backlight:intel_backlight"), { locked = true })

-- Playback (Spotify)
hl.bind(mainMod .. " + N",         hl.dsp.exec_cmd("playerctl -p spotify next"))
hl.bind(mainMod .. " + P",         hl.dsp.exec_cmd("playerctl -p spotify previous"))
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd("playerctl -p spotify play-pause"))
