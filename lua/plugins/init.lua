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
}

-- 		-- Multicursor select
-- 		-- use("terryma/vim-multiple-cursors")
--
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
-- 		-- =================WRITING================
-- 		use({
-- 			"vim-pandoc/vim-pandoc",
-- 			setup = function()
-- 				require("user.pandoc")
-- 			end,
-- 			requires = "vim-pandoc/vim-pandoc-syntax",
-- 		})
--         -- Allows us to make ascii tables easily in markdown
-- 		use()
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
-- 		use()
-- 		--it changes
-- 		use()
-- 	end,
--
-- 	config = {
-- 		display = {
-- 			open_fn = require("packer.util").float,
-- 		},
-- 	},
-- })
