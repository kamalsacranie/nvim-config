return {
	"lukas-reineke/indent-blankline.nvim",
	config = function()
		require("user.indent_blankline")
	end,
	dependencies = { "mason.nvim" },
	enabled = false,
}
