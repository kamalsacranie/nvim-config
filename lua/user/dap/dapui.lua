local dap_did_load, dap = load_package("dap")
if not dap_did_load then
	return
end
-- must be in its own place as we force laoding after dap
local dapui = require("dapui")
dapui.setup()
dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end

-- add if exists condition/ maybe in packer
vim.keymap.set("n", "<leader>dt", function()
	return require("dapui").toggle({})
end, { buffer = true })
