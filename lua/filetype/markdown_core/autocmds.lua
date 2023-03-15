local create_augroup = vim.api.nvim_create_augroup
local create_autocmd = vim.api.nvim_create_autocmd

-- folding (make this into a lua function??)
--[[ vim.cmd[[
function! MarkdownLevel()
    let h = matchstr(getline(v:lnum), '^#\+ ')
    if empty(h)
        return "="
    else
        return ">" . len(h)
endif
endfunction
]]
--]]

-- local ts_patch = create_augroup("ts_patch", { clear = true }) -- Turning off treesitter highlighting
-- create_autocmd("BufWinEnter", {
-- 	group = ts_patch,
-- 	callback = function()
-- 		vim.cmd([[TSBufDisable highlight]])
-- 	end,
-- 	pattern = { "*.md", "*.anki", "*.rmd" },
-- 	desc = "Treeshitter shim to stop highlighting",
-- })

-- local md_core_cleanup = create_augroup("md_core_cleanup", { clear = true })
-- create_autocmd("BufWinEnter", {
-- 	group = md_core_cleanup,
-- 	callback = function()
-- 		vim.cmd([[setlocal foldexpr=MarkdownLevel()]]) -- setting our fold function when we enter
-- 	end,
-- 	pattern = { "*.md", "*.anki", "*.rmd" },
-- 	desc = "Markdown cleanup pre BufWinEnter",
-- })

local in_codeblock = function()
	local node = require("nvim-treesitter.ts_utils").get_node_at_cursor(0)
	-- prevents error if no node
	if not node then
		return false
	end
	local parents =
		require("utils.treesitter-helpers").get_all_parent_nodes(node)
	parents = map(parents, function(node)
		return node:type()
	end, true)
	if parents == nil then
		return
	end
	local highest_parent = parents[#parents]
	if
		-- we can do this better
		highest_parent ~= "inline"
		and highest_parent ~= "document"
		and highest_parent ~= "source_file"
	then
		return true
	end
	return false
end

local augroup = create_augroup("temp", { clear = true })
create_autocmd({ "InsertEnter" }, {
	pattern = { "*.md", "*.qmd" },
	group = augroup,
	callback = function()
		local loaded, femaco = load_package("femaco.edit")
		if not loaded then
			return
		end
		if in_codeblock() then
			femaco.edit_code_block()
		end
	end,
})
