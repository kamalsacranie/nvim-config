-- Can't use my QOL function here for some reason
vim.cmd([[setlocal colorcolumn=73]])

local create_augroup = vim.api.nvim_create_augroup
local create_autocmd = vim.api.nvim_create_autocmd

local gitcommit_cleanup = create_augroup("gitcommit_cleanup", { clear = true })
create_autocmd("BufEnter", {
	group = gitcommit_cleanup,
	callback = function()
		return
	end,
	pattern = "*COMMIT_EDITMSG*",
	desc = "Gitcommit cleanup when we go into buffer",
})

require("utils.spell")
