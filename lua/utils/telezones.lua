local M = {}
M.search_dotfiles = function()
	-- This allows us to create the custom tele env
	require("telescope.builtin").find_files({
		prompt_title = "NVimRC",
		-- Specifies where tele should look
		cwd = vim.env.XDG_CONFIG_HOME .. "/nvim",
		hidden = true,
	})
end

M.search_notes = function()
	-- This allows us to create the custom tele env
	require("telescope.builtin").find_files({
		prompt_title = "General Notes",
		-- Specifies where tele should look
		cwd = vim.env.HOME .. "/Documents/learning-and-general-notes",
		hidden = true,
	})
end

return M
