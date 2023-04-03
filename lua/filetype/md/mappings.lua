-- Render pdf
vim.keymap.set("n", "<leader>r", function()
	vim.cmd([[write]])
	vim.fn.jobstart(
		{ "quarto", "render", vim.fn.expand("%:p") },
		{ detach = true }
	)
end)
