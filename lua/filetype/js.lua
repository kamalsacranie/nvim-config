local M = require("filetype.js_core")
vim.keymap.set(
	"n",
	"<leader>r",
	"<Cmd>w<CR><Cmd>TermExec direction='horizontal' cmd='node %' go_back=0<CR>"
)
return M
