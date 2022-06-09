local hin_did_load, _ = load_package("highlight_current_n")
if not hin_did_load then
	return
end

require("user.mappings.search_hl_map")
vim.api.nvim_create_augroup("ClearSearchHL", { clear = true })
vim.api.nvim_create_autocmd("CmdlineEnter", {
	group = "ClearSearchHL",
	pattern = [[/,\?]],
	command = "set hlsearch",
})
vim.api.nvim_create_autocmd("CmdlineLeave", {
	group = "ClearSearchHL",
	pattern = [[/,\?]],
	command = "set nohlsearch",
})
vim.api.nvim_create_autocmd("CmdlineLeave", {
	group = "ClearSearchHL",
	pattern = [[/,\? lua]],
	command = "lua require('highlight_current_n')['/,?']()",
})
