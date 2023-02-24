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
		vim.cmd([[colorscheme kanagawa]])
	end,
}
