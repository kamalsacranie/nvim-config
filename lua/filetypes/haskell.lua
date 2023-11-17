local M = {}

M.dap_config_extend = {
	adapter = {
		type = "executable",
		command = "haskell-debug-adapter",
		args = { "--hackage-version=0.0.33.0" },
	},
	configuration = {
		type = "haskell",
		request = "launch",
		name = "Debug",
		workspace = "${workspaceFolder}",
		startup = "${file}",
		stopOnEntry = true,
		logFile = vim.fn.stdpath("data") .. "/haskell-dap.log",
		logLevel = "WARNING",
		ghciEnv = vim.empty_dict(),
		ghciPrompt = "λ: ",
		ghciInitialPrompt = "λ: ",
		ghciCmd = "stack ghci --test --no-load --no-build --main-is TARGET --ghci-options -fprint-evld-with-show",
	},
}

return M
