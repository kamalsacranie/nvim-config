return {
	"mhartington/formatter.nvim",
	config = function()
		-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
		local util = require("formatter.util")
		require("formatter").setup({
			filetype = {
				markdown = {
					function()
						return {
							exe = "mdformat",
							args = {
								"--wrap",
								"80",
								util.escape_path(
									util.get_current_buffer_file_path()
								),
							},
							stdin = true,
						}
					end,
				},
			},
		})
	end,
	enabled = false,
}
