
hl.on("hyprland.start", function ()
  hl.exec_cmd("systemctl --user start hyprpolkitagent")
  hl.exec_cmd("systemctl --user enabe --now waybar.service")
  hl.exec_cmd("darkman run")
end)
