return {
	-- Surround things with things duh
	"tpope/vim-surround",
	-- Kitty config highlighting
	"fladson/vim-kitty",
	-- Devicons
	"kyazdani42/nvim-web-devicons",
	-- Highlight colour strings in nvim editr
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},
	-- LSP install things with mason
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup()
		end,
	},
	-- Document highlighting
	"andymass/vim-matchup",
	-- Good python indenting (might be obselete now)
	"Vimjas/vim-python-pep8-indent",
	{
		"jose-elias-alvarez/null-ls.nvim",
		-- we don't have a config setup here because this is called in our lsp init
		dependencies = "nvim-lua/plenary.nvim",
	},
	-- "kamalsacranie/nvim-jest-tester",
}
