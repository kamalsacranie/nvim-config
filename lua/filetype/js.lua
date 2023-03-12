local M = rerequire("filetype.javascript_core")
local ls = require("luasnip")

ls.filetype_extend("javascript", M.snippet_types)

vim.keymap.set(
	"n",
	"<leader>r",
	"<Cmd>w<CR><Cmd>TermExec direction='horizontal' cmd='node %' go_back=0<CR>"
)
return M
