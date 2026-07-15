

hl.config({
    input = {
        kb_layout  = "us,ara",
	kb_options = "grp:alt_shift_toggle,caps:escape,altwin:swap_alt_win",

        follow_mouse = 2,

        touchpad = {
            natural_scroll = true,
        },
    },
    cursor = {
	no_warps = true,
    },
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})

