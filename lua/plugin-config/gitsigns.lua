require('gitsigns').setup {
    keymaps = {
        noremap = true,
        -- v for version
        ['n <leader>vS'] = '<cmd>lua require"gitsigns".stage_buffer()<CR>',
        ['n <leader>vU'] = '<cmd>lua require"gitsigns".reset_buffer_index()<CR>'
    }
}
