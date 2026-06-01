local o = vim.o
local g = vim.g
local opt = vim.opt

-- spacja znak sumy (sigma)
g.mapleader = " "
g.maplocalleader = " "

-- wciencie
o.tabstop = 2
o.shiftwidth = 2

-- nie wiem jak to opipsać w słowach
o.breakindent = false

-- nerdziarskie fonty
g.have_nerd_font = true

o.number = true
o.relativenumber = false

o.showmode = false

g.clipboard = "wl-copy"
vim.schedule(function()
  o.clipboard = "unnamedplus" 
end) 

o.undofile = true

o.ignorecase = true
o.smartcase = true

-- Keep signcolumn on by default
o.signcolumn = "yes"

-- Decrease update time
o.updatetime = 250

-- Decrease mapped sequence wait time
o.timeoutlen = 300

-- Configure how new splits should be opened
o.splitright = true
o.splitbelow = true

o.list = true
opt.listchars = { tab = "  ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
o.inccommand = "split"

-- Show which line your cursor is on
o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
o.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
o.confirm = true
