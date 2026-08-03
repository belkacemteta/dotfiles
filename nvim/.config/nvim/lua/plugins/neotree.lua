return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    lazy = false,
    opts = {
      close_if_last_window = true,
      popup_border_style = "NC",
    },
    config = function()
      vim.keymap.set("n", "<leader>e", "<Cmd>Neotree toggle<CR>", { desc = "Toggle Neo-Tree" })
    end,
  }
}
