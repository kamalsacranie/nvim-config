local builtin = require("telescope.builtin")

local M = {}

-- Search current directory or cwd passed in
M.find_files = function(opts)
	local defaults = {
		cwd = require("telescope.utils").buffer_dir(),
		follow = true,
		hidden = true,
		no_ignore = true,
	}
	opts = opts or {}
	builtin.find_files(vim.tbl_deep_extend("force", defaults, opts))
end

-- Search vim config
M.nvim_config = function()
	-- This allows us to create the custom tele env
	builtin.find_files({
		prompt_title = "NVimRC",
		-- Specifies where tele should look
		cwd = vim.env.XDG_CONFIG_HOME .. "/nvim",
		hidden = true,
		follow = true,
	})
end

-- Search notes folder
M.notes = function()
	-- This allows us to create the custom tele env
	builtin.find_files({
		prompt_title = "General Notes",
		-- Specifies where tele should look
		cwd = vim.env.HOME .. "/Documents/learning-and-general-notes",
		hidden = true,
	})
end

-- ripgrep all files in directory
M.live_grep = function()
	builtin.live_grep({ cwd = require("telescope.utils").buffer_dir() })
end

M.doc_symbols = function()
	builtin.lsp_document_symbols({ show_line = true })
end

return M
