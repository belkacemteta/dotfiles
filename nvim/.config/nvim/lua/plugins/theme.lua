
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
        ---@param colors ColorScheme
        on_colors = function(colors)
          -- Visual selection & highlighting
          colors.visual = "#3a3a3a"               
          colors.bg_hl_line = "#1a1a1a"           
          colors.bg_completion = "#262626"        
          colors.bg_paren_match = "#444444"       
          
          -- UI accents & borders
          colors.accent = "#a6a6a6"               
          colors.accent_dark = "#737373"          
          colors.accent_light = "#d9d9d9"         
          colors.border = "#404040"               
          colors.border_highlight = "#8e8e8e"     

          -- Search & IncSearch
          colors.bg_yellow_intense = "#4a4a4a"    
          colors.bg_green_intense = "#383838"     

          -- ====================================================================
          -- SYNTAX HIGHLIGHTING OVERRIDES
          -- ====================================================================
          
          -- Structure & Variables: Pure white (reserving gray ONLY for comments)
          colors.fn = "#ffffff"                   
          colors.magenta = "#ffffff"              
          colors.keyword = "#ffffff"              
          colors.magenta_cooler = "#ffffff"
          colors.identifier = "#ffffff"           
          colors.cyan = "#ffffff"
          colors.builtin = "#ffffff"              
          colors.magenta_warmer = "#ffffff"
          
          -- Data & Types: Bold, lively Neobrutalist accents
          
          -- Strings: Punchy, vivid golden-yellow 
          colors.string = "#f5b83d"               
          colors.blue_warmer = "#f5b83d"

          -- Types & Classes: Sharp, clear cerulean blue
          colors.type = "#3d8bf5"                 
          colors.cyan_cooler = "#3d8bf5"
          
          -- Booleans & Warnings: Lively coral/orange-red
          colors.blue = "#f55d3d"                 
          colors.blue_faint = "#f55d3d"           

          -- Constants & Numbers: Warm copper/brown
          colors.constant = "#d97a3d"
          colors.rust = "#d97a3d"

          -- Regex, Escapes & Specials: Punchy flat green
          colors.special = "#3df58b"
          colors.green = "#3df58b"
          colors.green_warmer = "#3df58b"

          -- Preprocessors & Macros: Vivid neobrutalist magenta
          colors.preproc = "#d93df5"
          colors.magenta_intense = "#d93df5"
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
