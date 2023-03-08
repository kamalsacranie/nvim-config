return {
	require("plugins.writing.vim-table-mode"),
	-- require("plugins.writing.vim-pandoc"),
	{
		"edluffy/hologram.nvim",
		config = function()
			require("hologram").setup({
				auto_display = true,
			})
		end,
		cond = function()
			is_filetype({ ".md", ".qmd" })
		end,
	},
	require("plugins.writing.femaco-codeblock-editing"),
}
