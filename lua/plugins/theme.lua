-- Colorscheme

-- return {
-- 	"bluz71/vim-nightfly-guicolors",
-- 	config = function()
-- 		require("user.theme")
-- 	end,
-- }

return {
	"rebelot/kanagawa.nvim",
	config = function()
		require("kanagawa").setup({})
		vim.cmd([[colorscheme kanagawa]])
	end,
}
