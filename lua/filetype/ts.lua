local M = rerequire("filetype.javascript_core")

local ls = require("luasnip")
table.insert(M.snippet_types, "javascript")
ls.filetype_extend("typescript", M.snippet_types)

vim.keymap.set(
	"n",
	"<leader>r",
	"<Cmd>w<CR><Cmd>TermExec direction='horizontal' cmd='tsx %' go_back=0<CR>"
)

return M
