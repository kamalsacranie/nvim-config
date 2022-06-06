return require("packer").startup({
	function(use)
		-- Meta updation
		use({ "wbthomason/packer.nvim", run = "PackerUpdate" })
		-- Surround things with things duh
		use("tpope/vim-surround")
		-- Commentary
		use({ "numToStr/Comment.nvim" })
		-- Status line
		use("hoob3rt/lualine.nvim")
		-- Multicursor select
		-- use("terryma/vim-multiple-cursors")

		-- ============ LSP Related
		-- nvim lsp
		use({
			"neovim/nvim-lspconfig",
			requires = {
				"ray-x/lsp_signature.nvim",
				"williamboman/nvim-lsp-installer",
			},
		})
		-- Really good plugin for seeing your lsp load
		use({
			"j-hui/fidget.nvim",
			config = function()
				require("user.fidget")
			end,
		})
		-- ===============

		-- Linting and formatting made easy
		use({
			"jose-elias-alvarez/null-ls.nvim",
			requires = { "nvim-lua/plenary.nvim" },
		})

		-- Document highlighting
		use({ "andymass/vim-matchup" })

		-- Tree shitter
		use({ "nvim-treesitter/nvim-treesitter", run = "TSUpdate" })
		use("windwp/nvim-ts-autotag")
		use("JoosepAlviste/nvim-ts-context-commentstring")
		use("p00f/nvim-ts-rainbow")
		use({ "nvim-treesitter/playground" })

		-- ============ Completion
		use({
			"hrsh7th/nvim-cmp",
			requires = {
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-nvim-lua",
				"quangnguyen30192/cmp-nvim-ultisnips",
				"jc-doyle/cmp-pandoc-references",
			},
		})

		-- =================PYTHON==================
		use({ "Vimjas/vim-python-pep8-indent", ft = { "python" }, opt = true })
		use("tweekmonster/django-plus.vim")
		use("alvan/vim-closetag")

		-- =================WRITING================
		use({
			"vim-pandoc/vim-pandoc",
			requires = {
				"vim-pandoc/vim-pandoc-syntax",
				{
					"ekickx/clipboard-image.nvim",
					keys = [[<leader>p]],
					config = function()
						require("user.clipboard_image")
					end,
				},
			},
		})
		use({
			"vim-pandoc/vim-rmarkdown",
			-- ft = {'rmarkdown'},
			requires = { "vim-pandoc/vim-pandoc" },
		})
		use({
			"dhruvasagar/vim-table-mode",
			ft = {
				"markdown",
				"rmarkdown",
				"rmd",
				"md",
				"anki.markdown.pandoc",
			},
		})
		-- =========================================

		-- R
		use({ "jalvesaq/Nvim-R", branch = "stable" })

		-- Snippets
		use({ "SirVer/ultisnips", requires = { "honza/vim-snippets" } })

		-- Autobrakcets
		use("windwp/nvim-autopairs")

		-- Telescope
		use({
			"nvim-telescope/telescope.nvim",
			requires = {
				"nvim-lua/plenary.nvim",
				{
					"nvim-telescope/telescope-fzf-native.nvim",
					run = "make",
				},
			},
		})

		-- Color scheme/theme
		use("bluz71/vim-nightfly-guicolors")
		-- Devicons
		use("kyazdani42/nvim-web-devicons")
		-- Proper search highlightig
		use("rktjmp/highlight-current-n.nvim")
		-- Popup terminal
		use({
			keys = [[<C-\>]],
			"akinsho/toggleterm.nvim",
			config = function()
				require("user.toggleterm")
			end,
		})

		-- Tabbing out of surrounding things
		use({
			"abecodes/tabout.nvim",
			config = function()
				require("user.tabout")
			end,
			requires = { "nvim-treesitter" },
			after = { "nvim-cmp" },
		})
		-- Making folds nicer: we could use require("pretty-fold").setup() but i
		-- need to look at the documentation for that becuase it looks like it will
		-- mess with treesitter out the box
		use({
			"anuvyklack/pretty-fold.nvim",
			requires = "anuvyklack/nvim-keymap-amend", -- only for preview
		})

		-- Color code highlightingh
		use("norcalli/nvim-colorizer.lua")
		-- Intent highlighting
		use({ "lukas-reineke/indent-blankline.nvim" })
		-- File explorer
		use({
			"kyazdani42/nvim-tree.lua",
			requires = {
				"kyazdani42/nvim-web-devicons",
			},
			-- TODO: Need to decide if i want to have the key only setup or do
			-- i want to set up the key before the requirement of plugin
			keys = "X",
			tag = "nightly",
			config = function()
				require("user.filetree")
			end,
		})
		-- Git changes
		use({
			"lewis6991/gitsigns.nvim",
			requires = "nvim-lua/plenary.nvim",
			-- Only config required
			config = function()
				require("user.gitsigns")
			end,
		})
	end,
	config = {
		display = {
			open_fn = require("packer.util").float,
		},
	},
})
