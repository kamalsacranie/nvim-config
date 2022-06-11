-- Render pdf
bkmap(
	"n",
	"<leader>r",
	"<Cmd>w<CR><Cmd>! pandoc -dlatex_basic % -o ./%:r.pdf<CR>"
)
