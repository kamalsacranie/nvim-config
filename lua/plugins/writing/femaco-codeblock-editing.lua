local setup_options = {
	-- should prepare a new buffer and return the winid
	-- by default opens a floating window
	-- provide a different callback to change this behaviour
	-- @param opts: the return value from float_opts
	prepare_buffer = function(opts)
		local buf = vim.api.nvim_create_buf(false, false)
		vim.keymap.set("n", "q", "<CMD>q<CR>", { buffer = buf })
		return vim.api.nvim_open_win(buf, true, opts)
	end,
	-- should return options passed to nvim_open_win
	-- @param code_block: data about the code-block with the keys
	--   * range
	--   * lines
	--   * lang
	float_opts = function(code_block)
		local clip_val = require("femaco.utils").clip_val
		local float_width = clip_val(5, 120, vim.api.nvim_win_get_width(0) - 10)
		local float_height =
			clip_val(5, #code_block.lines, vim.api.nvim_win_get_height(0) - 6)
		return {
			-- center window placement
			relative = "editor",
			width = float_width,
			height = float_height,
			anchor = "NW",
			row = (vim.api.nvim_win_get_height(0) - float_height) / 2,
			col = (vim.api.nvim_win_get_width(0) - float_width) / 2,
			style = "minimal",
			border = "rounded",
			zindex = 1,
		}
	end,
	-- return filetype to use for a given lang
	-- lang can be nil
	ft_from_lang = function(lang)
		return lang
	end,
	-- what to do after opening the float
	post_open_float = function(winnr)
		vim.wo.signcolumn = "no"
	end,
	-- create the path to a temporary file
	create_tmp_filepath = function(filetype)
		return os.tmpname()
	end,
	-- if a newline should always be used, useful for multiline injections
	-- which separators needs to be on separate lines such as markdown, neorg etc
	---@param base_filetype string The filetype which FeMaco is called from, not the
	-- filetype of the injected language (this is the current buffer so you can
	-- get it from vim.bo.filetype).
	ensure_newline = function(base_filetype)
		return true
	end,
}

return {
	"AckslD/nvim-FeMaco.lua",
	config = function()
		require("femaco").setup(setup_options)
	end,
	event = "InsertEnter",
	cond = function()
		return is_filetype({ "md", "qmd" })
	end,
}
