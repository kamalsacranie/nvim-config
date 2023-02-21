return {
	event = "BufWinEnter",
	"akinsho/toggleterm.nvim",
	config = function()
		require("user.toggleterm")
	end,
}
