vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.qmd",
	callback = function()
		vim.cmd([[set filetype=markdown]])
	end,
	desc = "QMD filetype",
})
