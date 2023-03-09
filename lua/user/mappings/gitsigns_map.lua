M = {}

M.gitsigns_mappings = function(bufnr)
	local gs = package.loaded.gitsigns
	local function map(mode, l, r, opts)
		opts = opts or {}
		opts.buffer = bufnr
		vim.keymap.set(mode, l, r, opts)
	end

	map("n", "]c", function()
		if vim.wo.diff then
			return "]c"
		end
		vim.schedule(function()
			gs.next_hunk()
		end)
		return "<Ignore>"
	end, { expr = true })

	map("n", "[c", function()
		if vim.wo.diff then
			return "[c"
		end
		vim.schedule(function()
			gs.prev_hunk()
		end)
		return "<Ignore>"
	end, { expr = true })

	-- Actions
	map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>")
	map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>")
	map("n", "<leader>gbs", gs.stage_buffer)
	map("n", "<leader>ghu", gs.undo_stage_hunk)
	map("n", "<leader>gbr", gs.reset_buffer)
	map("n", "<leader>ghp", gs.preview_hunk)
	map("n", "<leader>ghd", gs.diffthis)
	map("n", "<leader>ghD", function()
		gs.diffthis("~")
	end)
	map("n", "<leader>gtd", gs.toggle_deleted)
end

return M
