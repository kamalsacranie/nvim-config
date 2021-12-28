require('utils.markdown-core')

vim.cmd [[
augroup pandoc_syntax
  autocmd! BufNewFile,BufFilePre,BufRead *.md set syntax=markdown.pandoc
augroup END
]]

vim.cmd [[augroup rmarkdown
	autocmd!
	autocmd VimEnter * exec ":UltiSnipsAddFiletypes markdown-core"
augroup END]]

-- Render pdf
vim.api.nvim_buf_set_keymap(0, "n", "<leader>r",
                            "<Cmd>w<CR><Cmd>! mkdir -p pdf_output; pandoc % -o ./pdf_output/%:r.pdf<CR>",
                            {noremap = true, silent = true})
