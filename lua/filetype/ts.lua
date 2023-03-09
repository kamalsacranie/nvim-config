local M = rerequire("filetype.javascript_core")

M.luasnip_config_extend = {
	ft_func = function()
		return M.snippet_types
	end,
}

vim.keymap.set(
	"n",
	"<leader>r",
	"<Cmd>w<CR><Cmd>TermExec direction='horizontal' cmd='ts-node --esm %' go_back=0<CR>"
)

return M
