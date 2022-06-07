local hin_did_load, _ = load_package("highlight_current_n")
if not hin_did_load then
	return
end

-- vim.cmd([[
-- augroup ClearSearchHL
--   autocmd!
--   " You may only want to see hlsearch /while/ searching, you can automatically
--   " toggle hlsearch with the following autocommands
--   autocmd CmdlineEnter /,\? set hlsearch
--   autocmd CmdlineLeave /,\? set nohlsearch
--   " this will apply similar n|N highlighting to the first search result
--   " careful with escaping ? in lua, you may need \\?
--   autocmd CmdlineLeave /,\? lua require('highlight_current_n')['/,?']()
-- augroup END
-- ]])

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
