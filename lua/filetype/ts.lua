local M = rerequire("filetype.javascript_core")

local ls = require("luasnip")
ls.filetype_extend("typescript", M.snippet_types)

vim.keymap.set(
	"n",
	"<leader>r",
	"<Cmd>w<CR><Cmd>TermExec direction='horizontal' cmd='ts-node --esm %' go_back=0<CR>"
)

return M
