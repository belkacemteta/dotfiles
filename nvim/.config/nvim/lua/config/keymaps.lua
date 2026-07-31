
local map = vim.keymap.set

-- Clear highlights on search when pressing <Esc> in normal mode
map('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Telescope
local builtin = require('telescope.builtin')
map('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
map('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })

-- Folding
map("n", "<leader>zz", "za", { desc = "Toggle fold under cursor" })
map("n", "<leader>zZ", "zA", { desc = "Toggle fold recursively" })
map("n", "<leader>zO", "zR", { desc = "Open all folds in buffer" })
map("n", "<leader>zC", "zM", { desc = "Close all folds in buffer" })
map("n", "<leader>zn", "zj", { desc = "Move to next fold" })
map("n", "<leader>zp", "zk", { desc = "Move to previous fold" })

-- Indenting
vim.keymap.set("n", "<leader>i", "==", { desc = "Auto-indent line" })
vim.keymap.set("v", "<leader>i", "=", { desc = "Auto-indent selection" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and stay in visual mode" })
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and stay in visual mode" })

-- Buffer
vim.keymap.set("n", "<leader>bf", function()
  vim.lsp.buf.format()
end, { desc = "Format current buffer with LSP" })



-- [[ Basic Autocommands ]]
-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})
