
return {
    {
        -- Minimal, stark statusline at the bottom of the editor
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
          options = {
              --theme = "base16",
              component_separators = { left = "│", right = "│" },
              section_separators = { left = "", right = "" },
              globalstatus = true,
          },
        },
    },
}
