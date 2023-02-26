return {
	"vim-pandoc/vim-pandoc",
	setup = function()
		require("user.pandoc")
	end,
	dependencies = "vim-pandoc/vim-pandoc-syntax",
	enabled = false,
}
