local M = rerequire("filetype.js_core")

M.buffer_options = {
	-- Setting tabs,
	tabstop = 2,
	softtabstop = 2,
	shiftwidth = 0,
	expandtab = true,
	-- Setting width and colorcolumn,
	textwidth = 80,
}
vim.schedule(function()
	options_set(M.buffer_options, "bo")
end)

M.luasnip_config_extend = {
	ft_func = function()
		return { "javascript" }
	end,
}

vim.keymap.set(
	"n",
	"<leader>r",
	"<Cmd>w<CR><Cmd>TermExec direction='horizontal' cmd='ts-node %' go_back=0<CR>"
)

return M
