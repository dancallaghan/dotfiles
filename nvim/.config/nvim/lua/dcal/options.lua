local g   = vim.g
local opt = vim.opt
local cmd = vim.cmd

g.mapleader = ','

-- misc
opt.colorcolumn = '80'
opt.completeopt = 'menu'
opt.cmdheight = 2
opt.cursorline = true
opt.list = true
opt.path = opt.path + { '**' }
opt.showtabline = 2
opt.splitbelow = true
opt.splitright = true
opt.switchbuf = 'usetab'
opt.undofile = true
opt.wildmode = 'longest:full'
opt.wrap = false

-- tabs
opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2

-- theme
opt.background = 'dark'
cmd([[colorscheme gruvbox]])
