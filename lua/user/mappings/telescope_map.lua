-- These are our telescope mappings
local telescope_did_load, _ = load_package("telescope")
if not telescope_did_load then
	return
end

-- Keymappings: f for find
-- other files in cwd
vim.keymap.set("n", "<leader>ff", function()
	require("plugins.telescope.telezones").find_files()
end)
vim.keymap.set("n", "<leader>fF", function()
	require("plugins.telescope.telezones").find_files({
		cwd = require("utils.helpers").root_directory_from_pattern(
			vim.fn.getcwd(0),
			".git"
		),
	})
end)

-- grep text in files
kmap(
	"n",
	"<leader>fg",
	"<CMD>lua require('plugins.telescope.telezones').live_grep()<CR>"
)

-- list buffers
kmap("n", "<leader>fb", "<CMD>lua require('telescope.builtin').buffers()<CR>")

-- fuzzy search helptags
kmap("n", "<leader>fh", "<CMD>lua require('telescope.builtin').help_tags()<CR>")

-- Vimrc file searc
kmap(
	"n",
	"<leader>fv",
	"<CMD>lua require('plugins.telescope.telezones').nvim_config()<CR>"
)

-- Notes search
kmap(
	"n",
	"<leader>fn",
	"<CMD>lua require('plugins.telescope.telezones').notes()<CR>"
)

-- Show all keymaps
kmap("n", "<leader>fk", "<CMD>lua require('telescope.builtin').keymaps()<CR>")

-- Show document symbols
kmap(
	"n",
	"<leader>fs",
	"<CMD>lua require('plugins.telescope.telezones').doc_symbols()<CR>"
)

kmap("n", "<C-g>", "<CMD>lua pcall(require('telescope.builtin').git_files)<CR>")

-- This is probably my best achievement ever
local ranger_bookmarks_table =
	require("utils.ranger_bookmarks").ranger_bookmarks_table()
if ranger_bookmarks_table then
	for _, bookmark in ipairs(ranger_bookmarks_table) do
		local mark, path = unpack(bookmark)
		kmap(
			"n",
			"<leader>fr" .. mark,
			"<Cmd>lua require('plugins.telescope.telezones').find_files({ cwd = '"
				.. path
				.. "'})<CR>"
		)
	end
end
