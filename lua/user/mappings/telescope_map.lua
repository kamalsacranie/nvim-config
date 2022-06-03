-- These are our telescope mappings
local is_loaded, telescope = LOAD_PACKAGE("telescope")
if not is_loaded then
	return
end

-- Keymappings: f for find
-- other files in cwd
KMAP(
	"n",
	"<leader>ff",
	"<CMD>lua require('user.telescope').current_directory()<CR>"
)

-- grep text in files
KMAP("n", "<leader>fg", "<CMD>lua require('user.telescope').live_grep()<CR>")

-- list buffers
KMAP("n", "<leader>fb", "<CMD>lua require('user.telescope').buffers()<CR>")

-- fuzzy search helptags
KMAP("n", "<leader>fh", "<CMD>lua require('telescope.builtin').help_tags()<CR>")

-- Git project files. very naaace
KMAP("n", "<C-g>", "<CMD>lua require('telescope.builtin').git_files()<CR>")

-- Vimrc file searc
KMAP("n", "<leader>fv", "<CMD>lua require('user.telescope').nvim_config()<CR>")

-- Notes search
KMAP("n", "<leader>fn", "<CMD>lua require('user.telescope').notes()<CR>")

-- Show all keymaps
KMAP("n", "<leader>fk", "<CMD>lua require('telescope.builtin').keymaps()<CR>")

-- Show document symbols
KMAP("n", "<leader>fds", "<CMD>lua require('user.telescope').doc_symbols()<CR>")
