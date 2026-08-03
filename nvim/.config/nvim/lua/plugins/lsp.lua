return {
  {
    "mason-org/mason.nvim",
    opts = {
      firewall = {
        enabled = true
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    -- mason-lspconfig will handle enabling the servers automatically.
    config = function()
      -- get lua to recognize vim keyword
      vim.lsp.config('lua_ls', {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      })

      -- Create an autocommand group for keybinds
      local lsp_group = vim.api.nvim_create_augroup("UserLspConfig", {})

      vim.api.nvim_create_autocmd("LspAttach", {
        group = lsp_group,
        callback = function(ev)
          -- 'opts' ensures the keybinds are only active in the current buffer
          local opts = { buffer = ev.buf, silent = true }
          local map = vim.keymap.set

          -- Navigation
          map("n", "gd", vim.lsp.buf.definition, opts)
          map("n", "gD", vim.lsp.buf.declaration, opts)
          map("n", "gr", vim.lsp.buf.references, opts)
          map("n", "gi", vim.lsp.buf.implementation, opts)

          -- Documentation & Actions
          map("n", "K", vim.lsp.buf.hover, opts)
          map("n", "<leader>rn", vim.lsp.buf.rename, opts)
          map({"n", "v"}, "<leader>ca", vim.lsp.buf.code_action, opts)

          -- Diagnostics
          map("n", "]d", vim.diagnostic.goto_next, opts)
          map("n", "[d", vim.diagnostic.goto_prev, opts)
          map("n", "gl", vim.diagnostic.open_float, opts) -- Shows full error text in a floating window
        end,
      })
    end,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {
      ensure_installed = {
        "lua_ls",
      },
    },
  },


  -- Bridge for conform and nvim-lint --see below
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "mason-org/mason.nvim" },
    opts = {
      ensure_installed = {
        -- Formatters
        "stylua",     -- Lua formatter
        "prettier",   -- Web / JSON / Markdown formatter
        -- Linters
        "shellcheck", -- Bash/sh linter
        "eslint_d", -- JS linter
      },
    },
  },

  -- FORMATTING: conform.nvim
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" }, -- Loads right before you save
    keys = {
      {
        "<leader>bf",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        mode = "",
        desc = "Format buffer",
      },
    },
    opts = {
      -- Define which formatters to use per filetype
      formatters_by_ft = {
        lua = { "stylua" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        json = { "prettier" },
        markdown = { "prettier" },
        sh = { "shfmt" },
      },
      -- Optional: Format on save automatically
      --  format_on_save = {
      --  timeout_ms = 500,
      --  lsp_fallback = true, -- If no tool is installed, ask the LSP to format
      -- },
    },
  },

  -- LINTING: nvim-lint
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local lint = require("lint")

      -- Define which linters to use per filetype
      lint.linters_by_ft = {
        sh = { "shellcheck" },
        javascript = { "eslint_d" },
      }

      -- Create an autocommand to trigger linting automatically
      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
}
