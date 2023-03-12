return {
	"mfussenegger/nvim-dap",
	config = function()
		require("plugins.dap.dap")
	end,
	dependencies = {
		{
			"rcarriga/nvim-dap-ui",
			config = function()
				require("plugins.dap.dapui")
			end,
			-- Requires nvim-dap to be active because we only activate dap on bufenter
			-- after = "nvim-dap",
		},
		"theHamsta/nvim-dap-virtual-text",
		"nvim-telescope/telescope-dap.nvim",
	},
	-- only sets up on bufwinenter so we have the ft. Alternatively could perform a check for the setting in our custom ft and not load at all. idk
	event = "BufWinEnter",
}
