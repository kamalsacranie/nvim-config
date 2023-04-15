local M = {}

vim.cmd([[setlocal colorcolumn=80]])

-- Neogen filteyp specific configuration
M.neogen_config_extend = {
	languages = {
		python = {
			template = {
				annotation_convention = "numpydoc",
			},
		},
	},
}

-- Dap filetype specific configuration
M.dap_config_extend = {
	adapter = {
		type = "executable",
		command = "/Users/kamalsacranie/.local/share/nvim/dap_server/debugby/bin/python",
		args = { "-m", "debugpy.adapter" },
	},
	configuration = {
		-- The first three options are required by nvim-dap
		type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
		request = "launch",
		name = "Launch file",

		-- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

		program = "${file}", -- This configuration will launch the current file if used.
		pythonPath = function()
			-- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
			-- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
			-- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
			local cwd = vim.fn.getcwd()
			if os.getenv("VIRTUAL_ENV") then
				return os.getenv("VIRTUAL_ENV") .. "/bin/python"
			elseif vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
				return cwd .. "/venv/bin/python"
			elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
				return cwd .. "/.venv/bin/python"
			else
				return vim.g.python3_host_prog
			end
		end,
	},
}

require("filetypes.python.mappings")

return M