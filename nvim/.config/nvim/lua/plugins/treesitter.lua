
return {
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
      end,
    })
  end,
}
