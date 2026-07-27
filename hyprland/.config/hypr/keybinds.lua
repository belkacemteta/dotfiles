
-- require("global")


-- shortcut for tilde and backtick for 65% keyboard
hl.bind("CTRL + ESCAPE", hl.dsp.send_shortcut({ mods = "", key = "asciitilde" }), { repeating = false })
hl.bind("SHIFT + ESCAPE", hl.dsp.send_shortcut({ mods = "SHIFT", key = "asciitilde" }), { repeating = false })

hl.bind(MAIN_MOD .. " + RETURN", hl.dsp.exec_cmd(TERMINAL))

local closeWindowBind = hl.bind(MAIN_MOD .. " + Q", hl.dsp.window.close())
-- closeWindowBind:set_enabled(false)

--hl.bind(MAIN_MOD .. " + SHIFT + Q", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(MAIN_MOD .. " + SHIFT + SPACE", hl.dsp.window.float({ action = "toggle" }))
hl.bind(MAIN_MOD .. " + B", hl.dsp.exec_cmd("pkill -SIGUSR1 waybar"))
hl.bind(MAIN_MOD .. " + SHIFT + B", hl.dsp.exec_cmd("pkill -SIGUSR2 waybar"))

-- Launch applications
hl.bind(MAIN_MOD .. " + E", hl.dsp.exec_cmd(FILE_MANAGER))
hl.bind(MAIN_MOD .. " + A", hl.dsp.exec_cmd(APP_PICKER))
hl.bind(MAIN_MOD .. " + U", hl.dsp.exec_cmd(SCREEN_LOCK))


-- toggle full screen for focused window
hl.bind(MAIN_MOD .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle", window = "activewindow"}))

-- Move focus with mainMod + arrow keys
hl.bind(MAIN_MOD .. " + h",  hl.dsp.focus({ direction = "left" }))
hl.bind(MAIN_MOD .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(MAIN_MOD .. " + k",    hl.dsp.focus({ direction = "up" }))
hl.bind(MAIN_MOD .. " + j",  hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(MAIN_MOD .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(MAIN_MOD .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

-- Move active window inside workspace
hl.bind(MAIN_MOD .. " + SHIFT + H", hl.dsp.window.move({direction = "left"}))
hl.bind(MAIN_MOD .. " + SHIFT + J", hl.dsp.window.move({direction = "down"}))
hl.bind(MAIN_MOD .. " + SHIFT + K", hl.dsp.window.move({direction = "up"}))
hl.bind(MAIN_MOD .. " + SHIFT + L", hl.dsp.window.move({direction = "right"}))

-- Example special workspace (scratchpad)
hl.bind(MAIN_MOD .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(MAIN_MOD .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(MAIN_MOD .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(MAIN_MOD .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

-- scripts
hl.bind(MAIN_MOD .. " + W",         hl.dsp.exec_cmd("change_wallpaper.sh"))
hl.bind(MAIN_MOD .. " + SHIFT + Q",         hl.dsp.exec_cmd("power_menu.sh"))

-- clipboard
hl.bind(MAIN_MOD .. " + V", hl.dsp.exec_cmd("cliphist list | wofi --dmenu --prompt \"clipboard\" | cliphist decode | wl-copy"))
hl.bind(MAIN_MOD .. " + SHIFT + V", hl.dsp.exec_cmd("cliphist wipe"))
