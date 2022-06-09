local clipimg_did_load, _ = load_package("clipboard-image")
if not clipimg_did_load then
	return
end

kmap("n", "<leader>p", "<Cmd>PasteImg<CR>")
