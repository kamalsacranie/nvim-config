local filet_did_load, _ = load_package("nvim-tree")
if not filet_did_load then
	return
end

-- X for explore
kmap("n", "X", "<CMD>NvimTreeToggle<CR>")
kmap("i", "<C-x>", "<CMD>NvimTreeToggle<CR>")
