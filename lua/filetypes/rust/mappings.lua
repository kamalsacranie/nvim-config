local h = require("utils.helpers")

vim.keymap.set({ "n" }, "<leader>r", function()
	local cd = h.current_buffer_dir()
	if not cd then
		return
	end
	if h.root_directory_from_pattern(cd, "Cargo.toml") then
		vim.cmd(
			[[:TermExec direction='horizontal' cmd='cargo run' go_back=0<CR>"]]
		)
	end
end)
