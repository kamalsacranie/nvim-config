require('utils.markdown-core')

vim.cmd [[augroup rmarkdown
	autocmd!
	autocmd VimEnter * exec ":UltiSnipsAddFiletypes markdown-core.rmarkdown"
augroup END]]

-- Render pdf
vim.api.nvim_buf_set_keymap(0, "n", "<leader>r",
                            "<Cmd>w<CR><Cmd>! if ls ${PWD}/*.Rproj &>/dev/null; then Rscript -e 'rmarkdown::render_site()'; else pandoc % -o %:r.pdf; fi;<CR>",
                            {noremap = true, silent = true})
