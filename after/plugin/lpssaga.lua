if not vim.g.loaded_lspsaga then
    return
end

local saga = require('lspsaga')

saga.init_lsp_saga {
    border_style = 'round',
}

-- Keymappings

local opts = { noremap = true, silent = true }
local bufremap = function(mode, lhs, rhs) 
    vim.api.nvim_buf_set_keymap(0, mode, lhs, rhs, opts)
end

-- Kyeremaps
bufremap('n', '<C-p>', '<Cmd>Lspsaga diagnostic_jump_prev<CR>')
bufremap('n', '<C-n>', '<Cmd>Lspsaga diagnostic_jump_next<CR>')
bufremap('n', 'gh', '<Cmd>lua require("lspsaga.diagnostic").show_line_diagnostics()<CR>')
bufremap('n', '<leader>fo', '<Cmd>Lspsaga lsp_finder<CR>')
bufremap('n', '<leader>rn', '<Cmd>lua require("lspsaga.rename").rename()<CR>')
bufremap('n', 'K', '<Cmd>lua require("lspsaga.hover").render_hover_doc()<CR>')
bufremap('i', '<C-k>', '<Cmd>lua require("lspsaga.signaturehelp").signature_help()<CR>')

-- float terminal also you can pass the cli command in open_float_terminal function
bufremap('n', '<A-d>', '<Cmd>lua require("lspsaga.floaterm").open_float_terminal()<CR>')
bufremap('t', '<A-d>', '<C-\\><C-n>:lua require("lspsaga.floaterm").close_float_terminal()<CR>')
