local dap_did_load, dap = load_package("dap")
if not dap_did_load then
	return
end

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

-- Get our dap tables form our filetype and return if they don't exist
local dap_options_to_extend = extend_config(nil, "dap_config_extend")
if next(dap_options_to_extend) == nil then
	return
end

-- Setup our dap config from our filetype dynamically (this plugin is only activateed after the buffer filetype has been defined)
dap.adapters[vim.bo.filetype] = dap_options_to_extend.adapter or {}
dap.configurations[vim.bo.filetype] = {
	dap_options_to_extend.configuration or {},
}

-- mapppings
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
