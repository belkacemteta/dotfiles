
return {
    {
        -- Minimal, stark statusline at the bottom of the editor
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
          options = {
              --theme = "cyberdream",
              -- Square section separators (no arrows or bubbles)
              component_separators = { left = "│", right = "│" },
              section_separators = { left = "", right = "" },
              globalstatus = true,
          },
        },
    },
}
