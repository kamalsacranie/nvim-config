local M = {}
vim.cmd([[setlocal colorcolumn=80]])
vim.keymap.set("n", "<leader>r", function()
	-- Run subprocess command and capture output
	local handle = io.popen("poetry show -v | head -n 1 | sed 's/^.*://g'")
	local output = handle:read("*a")
	handle:close()
	output = output:gsub("^%s*(.-)%s*$", "%1")

	-- Check if output matches absolute file path regex
	if string.match(output, "^/.*") then
		vim.cmd([[:w]])
		vim.cmd(
			[[:TermExec direction='horizontal' cmd='source ]]
				.. output
				.. [[/bin/activate; python3 %' go_back=0<CR>"]]
		)
	else
        -- needs to be heavilty refactored
		local handle = io.popen("poetry show -v | head -n 1 | sed 's/^.*://g'")
		local output = handle:read("*a")
		handle:close()
		if string.match(output, "^/.*") then
			vim.cmd([[:w]])
			vim.cmd(
				[[:TermExec direction='horizontal' cmd='source $VIRTUAL_ENV/bin/activate; python3 %' go_back=0<CR>]]
			)
		else
			vim.cmd([[:w]])
			vim.cmd(
				[[:TermExec direction='horizontal' cmd='python3 %' go_back=0<CR>]]
			)
		end
	end
end)

-- Treesitter filetype specific configuration
M.ts_config_extend = {
	indent = { enable = false }, -- we use a python specific plugin to handle indentation
}

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

return M
