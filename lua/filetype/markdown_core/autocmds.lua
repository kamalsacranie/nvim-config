local create_augroup = vim.api.nvim_create_augroup
local create_autocmd = vim.api.nvim_create_autocmd

-- folding (make this into a lua function??)
vim.cmd([[
function! MarkdownLevel()
    let h = matchstr(getline(v:lnum), '^#\+ ')
    if empty(h)
        return "="
    else
        return ">" . len(h)
endif
endfunction
]])

local ts_patch = create_augroup("ts_patch", { clear = true }) -- Turning off treesitter highlighting
create_autocmd("BufWinEnter", {
	group = ts_patch,
	callback = function()
		vim.cmd([[TSBufDisable highlight]])
	end,
	pattern = { "*.md", "*.anki", "*.rmd" },
	desc = "Treeshitter shim to stop highlighting",
})

-- local md_core_cleanup = create_augroup("md_core_cleanup", { clear = true })
-- create_autocmd("BufWinEnter", {
-- 	group = md_core_cleanup,
-- 	callback = function()
-- 		vim.cmd([[setlocal foldexpr=MarkdownLevel()]]) -- setting our fold function when we enter
-- 	end,
-- 	pattern = { "*.md", "*.anki", "*.rmd" },
-- 	desc = "Markdown cleanup pre BufWinEnter",
-- })
