local M = {}

vim.cmd([[setlocal colorcolumn=81]])
vim.bo.textwidth = 80
require("utils.spell")

return M
