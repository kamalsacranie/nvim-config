-- local M = require("filetype.md")
local M = {}

local otter = require("otter")
vim.api.nvim_create_autocmd({ "BufEnter" }, {
	pattern = { "*.md" },
	callback = function()
		otter.activate({ "r", "python", "lua", "javascript" }, true)
		vim.cmd([[TSBufEnable highlight]])
		vim.api.nvim_buf_set_keymap(
			0,
			"n",
			"gd",
			":lua require'otter'.ask_definition()<cr>",
			{ silent = true }
		)
		vim.api.nvim_buf_set_keymap(
			0,
			"n",
			"K",
			":lua require'otter'.ask_hover()<cr>",
			{ silent = true }
		)
	end,
})

vim.cmd("let g:pandoc#syntax#codeblocks#embeds#use=0")

return M
