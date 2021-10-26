-- Setting tabs
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 0
vim.opt.expandtab = true
-- Setting width and colorcolumn
vim.opt.textwidth = 79
vim.opt.colorcolumn = {80}

-- Setting up spell
require('utils.spell')

-- Keymaps
vim.api.nvim_set_keymap('n', 'gf', 'gf<C-w>o', {noremap = true})
vim.g['pandoc#hypertext#split_open_cmd'] = 'e'

-- require'clipboard-image'.setup {require('plugin-config/clipboard-image')}

-- Disabling tick autopair surely there has to be a better way to do this
-- not in the ftplugin idk
require('nvim-autopairs').remove_rule('```')
require('nvim-autopairs').remove_rule('`')

-- Render pdf
vim.api.nvim_set_keymap("n", "<leader>r",
                        "<Cmd>w<CR><Cmd>! pandoc % -o %:r.pdf<CR>",
                        {noremap = true, silent = true})

-- Tablemode settings
vim.cmd [[let g:table_mode_corner='|']]
