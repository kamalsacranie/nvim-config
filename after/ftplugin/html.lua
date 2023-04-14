local buffer_options = {
	tabstop = 2,
	softtabstop = 2,
	shiftwidth = 0,
	expandtab = true,
}

vim.schedule(function()
	options_set(buffer_options, "bo")
end)
