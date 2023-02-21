return {
	"lukas-reineke/indent-blankline.nvim",
	config = function()
		require("user.indent_blankline")
	end,
	after = "mason.nvim",
}
