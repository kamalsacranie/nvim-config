local themes = {
	kanagawa = {
		"rebelot/kanagawa.nvim",
		config = function()
			require("kanagawa").setup({})
			vim.cmd([[colorscheme kanagawa]])
		end,
	},
	catppuccin = {
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
				dim_inactive = {
					enabled = true, -- dims the background color of inactive window
				},
				styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
					comments = { "italic" }, -- Change the style of comments
					conditionals = { "italic" },
					loops = {},
					functions = {},
					keywords = {},
					strings = {},
					variables = {},
					numbers = {},
					booleans = { "bold" },
					properties = {},
					types = {},
					operators = {},
				},
				custom_highlights = {},
				integrations = {
					-- https://github.com/catppuccin/nvim#integrations
					cmp = true,
					gitsigns = true,
					nvimtree = true,
					treesitter = true,
					notify = true,
					markdown = true,
					mini = {
						enabled = true,
						indentscope_color = "",
					},
				},
			})
			vim.cmd([[colorscheme catppuccin]])
		end,
	},
}

return themes.catppuccin
