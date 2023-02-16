-- Render pdf
bkmap("n", "<leader>r", "<Cmd>w<CR><Cmd>! pandoc % -o ./%:r.pdf<CR>")
