local create_augroup = vim.api.nvim_create_augroup
local create_autocmd = vim.api.nvim_create_autocmd

local rmd_cleanup = create_augroup("rmd_cleanup", { clear = true })
create_autocmd("BufEnter", {
	group = rmd_cleanup,
	callback = function()
		return
	end,
	pattern = "*.rmd, *.rmarkdown",
	desc = "Rmarkdown cleanup when we go into buffer",
})
