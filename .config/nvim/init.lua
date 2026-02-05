-- ===============================
-- BASIC SETTINGS
-- ===============================

vim.opt.number = true        -- numeri di riga assoluti
vim.opt.relativenumber = true -- numeri di riga relativi

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"

vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"

vim.opt.cursorline = true

vim.opt.laststatus = 3 -- statusline globale

vim.opt.statusline = table.concat({
  " %f",        -- file name
  " %m",        -- modified
  "%=",
  " %y",        -- filetype
  " %l:%c ",    -- line:column
})
