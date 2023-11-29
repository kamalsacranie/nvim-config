local pastify = load_package("pastify")
if not pastify then
	return
end

vim.keymap.set("n", "<leader>p", "<Cmd>Pastify<CR>")
