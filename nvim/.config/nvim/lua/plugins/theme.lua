
return {
  {
    "miikanissi/modus-themes.nvim",
    priority = 1000,
    config = function()
      require("modus-themes").setup({
        -- Theme comes in two styles `modus_operandi` (light) and `modus_vivendi` (dark)
        -- `auto` will automatically set style based on background set with vim.o.background
        style = "auto",

        -- Theme comes in four variants `default`, `tinted`, `deuteranopia`, and `tritanopia`
        variants = {
          modus_operandi = "default", -- Set variant for `modus_operandi` style
          modus_vivendi = "default", -- Set variant for `modus_vivendi` style
        },
        transparent = false, -- Transparent background (as supported by the terminal)
        dim_inactive = false, -- "non-current" windows are dimmed
        hide_inactive_statusline = false, -- Hide statuslines on inactive windows. Works with the standard **StatusLine**, **LuaLine** and **mini.statusline**
        line_nr_column_background = true, -- Distinct background colors in line number column. `false` will disable background color and fallback to Normal background
        sign_column_background = true, -- Distinct background colors in sign column. `false` will disable background color and fallback to Normal background
        styles = {
          -- Style to be applied to different syntax groups
          -- Value is any valid attr-list value for `:help nvim_set_hl`
          comments = { italic = true },
          keywords = { italic = true },
          functions = {},
          variables = {},
        },

        --- You can override specific color groups to use other groups or a hex color
        --- Function will be called with a ColorScheme table
        --- Refer to `extras/lua/modus_operandi.lua` or `extras/lua/modus_vivendi.lua` for the ColorScheme table
        ---@param colors ColorScheme
        on_colors = function(colors)
          -- Visual selection & highlighting (removes the default purple/blue tint)
          colors.visual = "#3a3a3a"               -- Was #7030af (intense purple)
          colors.bg_hl_line = "#1a1a1a"           -- Was #2f3849 (blue-tinted dark gray)
          colors.bg_completion = "#262626"        -- Was #2f447f (blue)
          colors.bg_paren_match = "#444444"       -- Was #2f7f9f (teal-blue)
          
          -- UI accents & borders (shifts from bright blue to crisp monochrome slate/silver)
          colors.accent = "#a6a6a6"               -- Was #79a8ff (bright blue)
          colors.accent_dark = "#737373"          -- Was #338fff (blue)
          colors.accent_light = "#d9d9d9"         -- Was #82b0ec (light blue)
          colors.border = "#404040"               -- Was #646464 (medium gray)
          colors.border_highlight = "#8e8e8e"     -- Was #C4C4C4 (bright silver)

          -- Search & IncSearch (optional: replaces intense green/yellow background highlights)
          colors.bg_yellow_intense = "#4a4a4a"    -- Subtle graphite highlight instead of yellow
          colors.bg_green_intense = "#383838"     -- Subtle graphite highlight instead of green
        end,

        --- You can override specific highlights to use other groups or a hex color
        --- Function will be called with a Highlights and ColorScheme table
        --- Refer to `extras/lua/modus_operandi.lua` or `extras/lua/modus_vivendi.lua` for the Highlights and ColorScheme table
        ---@param highlights Highlights
        ---@param colors ColorScheme
        on_highlights = function(highlights, colors) end,
      })
      vim.cmd("colorscheme modus")
    end,
  }
}
