local gs_did_load, _ = load_package("gitsigns")
if not gs_did_load then
	return
end

bkmap("n", "<leader>ghs", "<Cmd>lua require'gitsigns'.stage_hunk()<CR>")
bkmap("v", "<leader>ghs", "<Cmd>lua require'gitsigns'.stage_hunk()<CR>")
bkmap("n", "<leader>gbs", "<Cmd>lua require'gitsigns'.stage_buffer()<CR>")
bkmap("v", "<leader>gbs", "<Cmd>lua require'gitsigns'.stage_buffer()<CR>")
