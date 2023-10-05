local pastify_did_load, _ = load_package("pastify")
if not pastify_did_load then
	return
end

kmap("n", "<leader>p", "<Cmd>Pastify<CR>")
