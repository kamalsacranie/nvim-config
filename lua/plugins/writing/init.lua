return {
	require("plugins.writing.vim-table-mode"),
	require("plugins.writing.femaco-codeblock-editing"),
	require("plugins.writing.clipboard-image"),
	{
		"edluffy/hologram.nvim",
		config = function()
			require("hologram").setup({
				auto_display = true,
			})
		end,
		cond = function()
			return is_filetype({ "md", "qmd" })
		end,
	},
	cond = function()
		return is_filetype({ "md", "qmd" })
	end,
}
