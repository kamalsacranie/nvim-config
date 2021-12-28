require('utils.markdown-core')

vim.cmd [[augroup rmarkdown
	autocmd!
	autocmd BufEnter * exec ":UltiSnipsAddFiletypes markdown-core.rmarkdown"
augroup END]]


-- Render pdf
-- vim.api.nvim_buf_set_keymap(0, "n", "<leader>r",
--                             [[<Cmd>w<CR><Cmd>! if ls ${PWD}/*.Rproj &>/dev/null; then Rscript -e 'rmarkdown::render_site()'; else mkdir -p output; Rscript -e 'rmarkdown::render("%", output_dir="./output", output_format="all")'; rm %:r.log; fi;<CR>]],
--                             {noremap = true, silent = true})

-- Cant get the string to escape nicely to allow this to run in the popup
-- terminal
--render = [[if ls ${PWD}/*.Rproj &>/dev/null; then Rscript -e 'rmarkdown::render_site()'; else mkdir -p output; Rscript -e 'rmarkdown::render("%", output_dir="./output", output_format="all")'; rm %:r.log; fi]]
vim.api.nvim_buf_set_keymap(0, "n", "<leader>r",
                            [[<Cmd>w<CR><Cmd>TermExec direction='horizontal' cmd='bookdown-render.sh "%"' go_back=0<CR>]],
                            {noremap = true, silent = true})
vim.api.nvim_buf_set_keymap(0, "n", "<leader>b",
                            [[<Cmd>w<CR><Cmd>silent! TermExec direction='float' cmd='cd $(git rev-parse --show-toplevel); papis list --format "@{doc[ref]}" | pbcopy; exit'<CR>]],
                            {noremap = true, silent = true})
