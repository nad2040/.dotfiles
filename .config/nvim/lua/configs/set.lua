-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.c_syntax_for_h = 1

vim.o.winborder = "rounded"

vim.o.number = true
vim.o.relativenumber = true

vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smartindent = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.wrap = false

vim.o.swapfile = false
vim.o.backup = false

vim.o.undodir = os.getenv("HOME") .. "/.local/state/nvim/undo"
vim.o.undofile = true

vim.o.hlsearch = false
vim.o.incsearch = true

vim.o.termguicolors = true

vim.o.scrolloff = 8
vim.o.signcolumn = "yes"

vim.o.isfname = vim.o.isfname .. ",@-@"

vim.o.updatetime = 50

vim.o.colorcolumn = ""

vim.o.foldmethod = "expr"
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
vim.o.foldenable = false -- Disable folding at startup.
