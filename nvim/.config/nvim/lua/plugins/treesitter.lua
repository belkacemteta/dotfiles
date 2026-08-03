
return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      local ts = require("nvim-treesitter")

      -- 1. Setup the plugin (uses default install directory)
      ts.setup({})

      -- 2. Install parsers for the languages you use
      -- (This is async and only installs if not already present)
      local languages = {
        "bash",
        "c",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "vim",
        "vimdoc",
        "yaml",
      }
      ts.install(languages)

      -- 3. Enable Neovim's native Treesitter highlighting & indentation
      vim.api.nvim_create_autocmd("FileType", {
        pattern = languages,
        callback = function()
          -- Enable native Neovim treesitter syntax highlighting
          vim.treesitter.start()

          -- Enable treesitter-based indentation (optional)
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

          -- Enable treesitter-based folding (optional)
          vim.wo.foldmethod = "expr"
          vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"

          -- Keybinds
          -- Folding
          vim.keymap.set("n", "<leader>zz", "za", { desc = "Toggle fold under cursor" })
          vim.keymap.set("n", "<leader>zZ", "zA", { desc = "Toggle fold recursively" })
          vim.keymap.set("n", "<leader>zO", "zR", { desc = "Open all folds in buffer" })
          vim.keymap.set("n", "<leader>zC", "zM", { desc = "Close all folds in buffer" })
          vim.keymap.set("n", "<leader>zn", "zj", { desc = "Move to next fold" })
          vim.keymap.set("n", "<leader>zp", "zk", { desc = "Move to previous fold" })

          -- Indenting
          vim.keymap.set("n", "<leader>i", "==", { desc = "Auto-indent line" })
          vim.keymap.set("v", "<leader>i", "=", { desc = "Auto-indent selection" })
          vim.keymap.set("v", ">", ">gv", { desc = "Indent right and stay in visual mode" })
          vim.keymap.set("v", "<", "<gv", { desc = "Indent left and stay in visual mode" })

          -- Buffer
          --vim.keymap.set("n", "<leader>bf", function()
          --  vim.lsp.buf.format()
          --end, { desc = "Format current buffer with LSP" })
        end,
      })
    end,
  },
  -- this handles installing new languages so i don't have to specify them manually.
  {
    "romus204/tree-sitter-manager.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("tree-sitter-manager").setup({
        auto_install = true, -- Automatically installs missing parsers on new filetypes
        highlight = true,    -- Automatically enables native TS highlighting
      })
    end,
  },
}
