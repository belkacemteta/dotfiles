
-- Enable undo/redo changes even after closing and reopening a file
vim.o.undofile = true
--vim.o.background = "light"

local opt = vim.opt

-- Use system clipboard by default
--opt.clipboard = "unnamedplus"

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Tabs & Indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.smartindent = true

-- Minimal UI visual clutter
opt.termguicolors = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.scrolloff = 8

-- Brutalist touch: Split windows with clean, solid characters
opt.fillchars = {
    vert = "│",
    horiz = "─",
    eob = " ", -- Hide '~' characters at the end of buffers
}

-- Folding options
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true
-- Remove ugly dashed filler lines and set clean fold indicators
opt.fillchars:append({
  fold = " ",
  foldopen = "",
  foldclose = "",
  foldsep = " ",
})
function _G.custom_foldtext()
  local line_text = vim.fn.getline(vim.v.foldstart)
  local total_lines = vim.v.foldend - vim.v.foldstart + 1
  return line_text .. "  ~ " .. total_lines .. " lines "
end
opt.foldtext = "v:lua.custom_foldtext()"
opt.foldcolumn = "1"
