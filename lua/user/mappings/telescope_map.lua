-- These are our telescope mappings
local telescope_did_load, _ = load_package("telescope")
if not telescope_did_load then
	return
end

-- Keymappings: f for find
-- other files in cwd
kmap(
	"n",
	"<leader>ff",
	"<CMD>lua require('user.telescope').current_directory()<CR>"
)

-- grep text in files
kmap("n", "<leader>fg", "<CMD>lua require('user.telescope').live_grep()<CR>")

-- list buffers
kmap("n", "<leader>fb", "<CMD>lua require('user.telescope').buffers()<CR>")

-- fuzzy search helptags
kmap("n", "<leader>fh", "<CMD>lua require('telescope.builtin').help_tags()<CR>")

-- Vimrc file searc
kmap("n", "<leader>fv", "<CMD>lua require('user.telescope').nvim_config()<CR>")

-- Notes search
kmap("n", "<leader>fn", "<CMD>lua require('user.telescope').notes()<CR>")

-- Show all keymaps
kmap("n", "<leader>fk", "<CMD>lua require('telescope.builtin').keymaps()<CR>")

-- Show document symbols
kmap("n", "<leader>fds", "<CMD>lua require('user.telescope').doc_symbols()<CR>")

if is_git_dir() then
	-- Git project files. very naaace
	kmap("n", "<C-g>", "<CMD>lua require('telescope.builtin').git_files()<CR>")
end
