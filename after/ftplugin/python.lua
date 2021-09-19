vim.opt.colorcolumn = '80'
vim.api.nvim_set_keymap("n", "<leader>r",
                        "<Cmd>TermExec direction='horizontal' cmd='python3 %' go_back=0<CR>",
                        {noremap = true, silent = true})
vim.opt.autoindent = true
