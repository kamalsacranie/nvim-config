-- No need to wrap in augroup according to vim's documentation on ftplugin
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.anki",
	callback = function()
		vim.cmd([[set filetype=anki]])
	end,
	desc = "Detecting anki filetype",
})
