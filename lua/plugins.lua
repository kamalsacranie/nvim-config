return require("packer").startup({
	function(use)
		-- Meta updation
		use({ "wbthomason/packer.nvim", run = "PackerUpdate" })
		-- Surround things with things duh
		use("tpope/vim-surround")
		-- Commentary
		use({
			"numToStr/Comment.nvim",
			config = function()
				require("user.comment")
			end,
		})
		-- Status line
		use({
			"hoob3rt/lualine.nvim",
			config = function()
				require("user.lualine")
			end,
		})
		-- Multicursor select
		-- use("terryma/vim-multiple-cursors")
		
		-- ============ LSP Related
		-- nvim lsp
		use({
			"neovim/nvim-lspconfig",
			config = function()
				require("user.lsp")
			end,
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
		use({
			"nvim-treesitter/nvim-treesitter",
			run = "TSUpdate",
			config = function()
				require("user.treesitter")
			end,
		})
		use("windwp/nvim-ts-autotag")
		use("JoosepAlviste/nvim-ts-context-commentstring")
		use("p00f/nvim-ts-rainbow")
		use("nvim-treesitter/playground")
		
		-- ============ Cuckpletion
		use({
			"hrsh7th/nvim-cmp",
			config = function()
				require("user.cmp")
			end,
			requires = {
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-nvim-lua",
				"quangnguyen30192/cmp-nvim-ultisnips",
				"jc-doyle/cmp-pandoc-references",
			},
		})
		
		-- =================WRITING================
		use({
			"ekickx/clipboard-image.nvim",
			keys = [[<leader>p]],
			config = function()
				require("user.clipboard_image")
			end,
		})
		use({
			"vim-pandoc/vim-pandoc",
			setup = function()
				require("user.pandoc")
			end,
			cond = function()
				return is_filetype({ "md", "markdown", "anki" })
			end,
			requires = "vim-pandoc/vim-pandoc-syntax",
		})
        -- Cannot be lazy lodaded due to markdown issues
		use({
			"dhruvasagar/vim-table-mode",
			config = function()
				vim.cmd([[let g:table_mode_header_fillchar="="]])
				vim.cmd([[let g:table_mode_corner="+"]])
				vim.cmd([[let g:table_mode_corner_corner="+"]])
			end,
		})
		-- =========================================
		
		-- Python
		use({
			"Vimjas/vim-python-pep8-indent",
			ft = "python",
		})
		
		-- R
		use({
			"jalvesaq/Nvim-R",
			branch = "stable",
			config = function()
				require("user.nvim_r")
			end,
			cond = function()
				return is_filetype({ "rmd" })
			end,
		})
		use({
			"vim-pandoc/vim-rmarkdown",
			cond = function()
				return is_filetype({ "rmd" })
			end,
			requires = {
				"vim-pandoc/vim-pandoc",
			},
		})
		
		-- Snippets
		use({
			"SirVer/ultisnips",
			config = function()
				require("user.ultisnips")
			end,
			requires = { "honza/vim-snippets" },
		})
		
		-- Autobrakcets
		use({
			"windwp/nvim-autopairs",
			config = function()
				require("user.autoparis")
			end,
		})
		
		-- Telescope
		use({
			"nvim-telescope/telescope.nvim",
			config = function()
				require("user.telescope")
			end,
			requires = {
				"nvim-lua/plenary.nvim",
				{
					"nvim-telescope/telescope-fzf-native.nvim",
					run = "make",
				},
			},
		})
		
		-- Color scheme/theme
		use({
			"bluz71/vim-nightfly-guicolors",
			config = function()
				require("user.theme")
			end,
		})
		-- Devicons
		use("kyazdani42/nvim-web-devicons")
		-- Proper search highlightig
		use({
			"rktjmp/highlight-current-n.nvim",
			keys = "/",
			config = function()
				require("user.search_highlight")
			end,
		})
		-- Popup terminal
		use({
			event = "BufWinEnter",
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
		-- Making folds nicer
		use({
			"anuvyklack/pretty-fold.nvim",
			config = function()
				require("user.pretty_fold")
			end,
			requires = "anuvyklack/nvim-keymap-amend", -- only for preview
		})
		
		-- Color code highlightingh
		use("norcalli/nvim-colorizer.lua")
		-- Intent highlighting
		use({
			"lukas-reineke/indent-blankline.nvim",
			config = function()
				require("user.indent_blankline")
			end,
		})
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
