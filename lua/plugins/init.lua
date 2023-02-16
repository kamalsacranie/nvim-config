return {
    -- Surround things with things duh
    "tpope/vim-surround",
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
}

-- 		-- Docstrings
-- 		use({
-- 			"danymat/neogen",
-- 			config = function()
-- 				require("user.neogen")
-- 			end,
-- 			requires = "nvim-treesitter/nvim-treesitter",
-- 		})
-- 		-- Commentary
-- 		use({
-- 			"numToStr/Comment.nvim",
-- 			config = function()
-- 				require("user.comment")
-- 			end,
-- 		})
-- 		-- Status line
-- 		use({
-- 			"hoob3rt/lualine.nvim",
-- 			config = function()
-- 				require("user.lualine")
-- 			end,
-- 		})
-- 		-- Multicursor select
-- 		-- use("terryma/vim-multiple-cursors")
--
-- 		-- ============ LSP Related
-- 		-- nvim lsp
-- 		use()
-- 		-- Really good plugin for seeing your lsp load
-- 		use({
-- 			"j-hui/fidget.nvim",
-- 			config = function()
-- 				require("user.fidget")
-- 			end,
-- 		})
-- 		-- ===============
--
-- 		-- ============ debugging ===========
-- 		use({
-- 			"mfussenegger/nvim-dap",
-- 			config = function()
-- 				require("user.dap.dap")
-- 			end,
-- 			requires = {
-- 				{
-- 					"rcarriga/nvim-dap-ui",
-- 					config = function()
-- 						require("user.dap.dapui")
-- 					end,
-- 					-- Requires nvim-dap to be active because we only activate dap on bufenter
-- 					after = "nvim-dap",
-- 				},
-- 				"theHamsta/nvim-dap-virtual-text",
-- 				"nvim-telescope/telescope-dap.nvim",
-- 			},
-- 			-- only sets up on bufwinenter so we have the ft. Alternatively could perform a check for the setting in our custom ft and not load at all. idk
-- 			event = "BufWinEnter",
-- 		})
-- 		-- ==================================
--
-- 		-- Linting and formatting made easy
-- 		use()
--
-- 		-- Tree shitter
-- 		use({
-- 			"nvim-treesitter/nvim-treesitter",
-- 			run = "TSUpdate",
-- 			config = function()
-- 				require("user.treesitter")
-- 			end,
-- 		})
-- 		use("windwp/nvim-ts-autotag")
-- 		use("JoosepAlviste/nvim-ts-context-commentstring")
-- 		use("p00f/nvim-ts-rainbow")
-- 		use("nvim-treesitter/playground")
--
-- 		-- ============ Cuckpletion
-- 		-- Snippets
-- 		use({
-- 			"L3MON4D3/LuaSnip",
-- 			tag = "v<CurrentMajor>.*",
-- 			config = function()
-- 				require("user.luasnip")
-- 			end,
-- 			after = "tabout.nvim",
-- 		})
-- 		-- cmp
-- 		use({
-- 			"hrsh7th/nvim-cmp",
-- 			config = function()
-- 				require("user.cmp")
-- 			end,
-- 			requires = {
-- 				"hrsh7th/cmp-nvim-lsp",
-- 				"hrsh7th/cmp-path",
-- 				"hrsh7th/cmp-nvim-lua",
-- 				"jc-doyle/cmp-pandoc-references",
-- 				"saadparwaiz1/cmp_luasnip",
-- 			},
-- 		})
--
-- 		-- =================WRITING================
-- 		use({
-- 			"ekickx/clipboard-image.nvim",
-- 			keys = [[<leader>p]],
-- 			config = function()
-- 				require("user.clipboard_image")
-- 			end,
-- 		})
-- 		use({
-- 			"vim-pandoc/vim-pandoc",
-- 			setup = function()
-- 				require("user.pandoc")
-- 			end,
-- 			requires = "vim-pandoc/vim-pandoc-syntax",
-- 		})
--         -- Allows us to make ascii tables easily in markdown
-- 		use({
-- 			"dhruvasagar/vim-table-mode",
-- 			config = function()
-- 				vim.cmd([[let g:table_mode_header_fillchar="="]])
-- 				vim.cmd([[let g:table_mode_corner="+"]])
-- 				vim.cmd([[let g:table_mode_corner_corner="+"]])
-- 			end,
-- 		})
-- 		-- =========================================
--
--
-- 		-- R
-- 		use({
-- 			"jalvesaq/Nvim-R",
-- 			branch = "stable",
-- 			config = function()
-- 				require("user.nvim_r")
-- 			end,
-- 			cond = function()
-- 				return vim.schedule(
-- 					function() -- Can't remember why we must schedule but we must
-- 						is_filetype({ "rmd", "R" })
-- 					end
-- 				)
-- 			end,
-- 		})
-- 		use({
-- 			"vim-pandoc/vim-rmarkdown",
-- 			-- Thinks I can bring this back now???
-- 			-- cond = function()
-- 			-- 	return is_filetype({ "rmd" })
-- 			-- end,
-- 			requires = {
-- 				"vim-pandoc/vim-pandoc",
-- 			},
-- 		})
--
-- 		-- Autobrakcets
-- 		use({
-- 			"windwp/nvim-autopairs",
-- 			config = function()
-- 				require("user.autoparis")
-- 			end,
-- 		})
--
--
-- 		-- Proper search highlightig
-- 		use({
-- 			"rktjmp/highlight-current-n.nvim",
-- 			keys = "/",
-- 			config = function()
-- 				require("user.search_highlight")
-- 			end,
-- 		})
-- 		-- Popup terminal
-- 		use({
-- 			event = "BufWinEnter",
-- 			"akinsho/toggleterm.nvim",
-- 			config = function()
-- 				require("user.toggleterm")
-- 			end,
-- 		})
--
-- 		-- Tabbing out of surrounding things
-- 		use({
-- 			"abecodes/tabout.nvim",
-- 			config = function()
-- 				require("user.tabout")
-- 			end,
-- 			requires = { "nvim-treesitter" },
-- 			after = { "nvim-cmp" },
-- 		})
-- 		-- Customise fold asthetics
-- 		use({
-- 			"anuvyklack/pretty-fold.nvim",
-- 			config = function()
-- 				require("user.folding").pretty_fold()
-- 			end,
-- 		})
-- 		-- Allows us to preview closed folds
-- 		use({
-- 			"anuvyklack/fold-preview.nvim",
-- 			requires = "anuvyklack/keymap-amend.nvim",
-- 			config = function()
-- 				require("user.folding").fold_preview()
-- 			end,
-- 		})
--
-- 		-- Indent highlighting
-- 		use({
-- 			"lukas-reineke/indent-blankline.nvim",
-- 			config = function()
-- 				require("user.indent_blankline")
-- 			end,
-- 			after = "mason.nvim",
-- 		})
-- 		--it changes
-- 		use({
-- 			"lewis6991/gitsigns.nvim",
-- 			requires = "nvim-lua/plenary.nvim",
-- 			-- Only config required
-- 			config = function()
-- 				require("user.gitsigns")
-- 			end,
-- 		})
-- 	end,
--
-- 	config = {
-- 		display = {
-- 			open_fn = require("packer.util").float,
-- 		},
-- 	},
-- })
