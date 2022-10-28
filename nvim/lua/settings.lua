vim.o.syntax = "on"
vim.o.termguicolors = true
vim.o.mouse = "a"
vim.o.number = true
vim.o.cursorline = true
vim.o.relativenumber = true
vim.o.tabstop = 4
vim.o.softtabstop = 0
vim.o.expandtab = false
vim.o.shiftwidth = 4
vim.o.smarttab = true
vim.o.autoindent = true
vim.o.encoding = "utf-8"
vim.o.fileencodings = "ucs-bom,utf-8,cp1251,cp1252,default,latin9"
vim.o.hidden = true
vim.o.scrolloff = 0
vim.o.ignorecase = true
vim.o.wrap = false
vim.o.cmdheight = 2
vim.o.pumheight = 10
vim.o.inccommand = "split"
vim.o.foldmethod = "marker"
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.backup = false
vim.o.writebackup = false
vim.o.updatetime = 300
vim.o.signcolumn = "yes:3"
vim.o.timeoutlen = 300

vim.g.mapleader = " "

vim.opt.shortmess:append("c")
vim.opt.virtualedit:append("onemore")
vim.opt.iskeyword:append("-")

vim.api.nvim_command("colorscheme hydrate")
vim.api.nvim_command("filetype plugin indent on")
