

hl.monitor({
    output   = "eDP-1",
    position = "0x0",
})

hl.monitor({
    output   = "HDMI-A-1",
    mode     = "1920x1080@100",
    position = "-1920x0",
    scale    = "auto",
})

hl.monitor({ 
    output = "", 
    mode = "preferred", 
    position = "auto", 
    scale = 1 
})

-- Assign workspaces 1 through 5 to HDMI-A-1
for i = 1, 5 do
    hl.workspace_rule({
        workspace = tostring(i),
        monitor = "HDMI-A-1",
        persistent = true
    })
end

-- Assign workspaces 6 through 10 to eDP-1
for i = 6, 10 do
    hl.workspace_rule({
        workspace = tostring(i),
        monitor = "eDP-1",
        persistent = true
    })
end
