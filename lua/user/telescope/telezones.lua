local builtin = require("telescope.builtin")

local M = {}

-- Search current directory
M.current_directory = function()
	builtin.find_files({
		cwd = require("telescope.utils").buffer_dir(),
		follow = true,
		hidden = true,
		no_ignore = true,
	})
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

-- Search all buffers
M.buffer = function()
	builtin.buffers({ ignore_current_buffer = true })
end

M.doc_symbols = function()
	builtin.lsp_document_symbols({ show_line = true })
end

return M
