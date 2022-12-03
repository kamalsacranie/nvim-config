-- Custom dap symbols
-- Must figure out how to give color
local dap_symbols = {
	DapBreakpoint = "",
	DapBreakpointCondition = "",
	DapLogPoint = "",
	DapStopped = "",
	DapBreakpointRejected = "",
}
for sign, symbol in pairs(dap_symbols) do
	vim.fn.sign_define(
		sign,
		{ text = symbol, texthl = "", linehl = "", numhl = "" }
	)
end

local dap = require("dap")

-- Get our dap tables form our filetype and return if they don't exist
local dap_tables = EXTEND_CONFIG(nil, "dap")
if next(dap_tables) == nil then
	return
end

-- Setup our dap config from our filetype dynamically (this plugin is only activateed after the buffer filetype has been defined)
dap.adapters[vim.bo.filetype] = dap_tables.adapter or {}
dap.configurations[vim.bo.filetype] = {
	dap_tables.configuration or {},
}

-- mapppings
vim.keymap.set("n", "<leader>dt", function()
	return require("dapui").toggle({})
end, { buffer = true })
vim.keymap.set("n", "<leader>dd", function()
	return require("dap").continue()
end, { buffer = true })
vim.keymap.set("n", "<leader>df", function()
	return require("dap").step_into()
end, { buffer = true })
vim.keymap.set("n", "<leader>do", function()
	return require("dap").step_over()
end, { buffer = true })
vim.keymap.set("n", "<leader>db", function()
	return require("dap").toggle_breakpoint()
end, { buffer = true })
