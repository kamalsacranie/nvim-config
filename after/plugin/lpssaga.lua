-- We just use Lspsaga for its absolute essentials
-- This is because some of the things in saga work well and others are broke
-- DON'T CALL LSPSAGA OTHERWISE THESE TWO LIGHTBULBS COME UP AND ITS THE MOST
-- ANNOYING THING
-- Keymappings
local opts = {noremap = true, silent = true}
local bufremap = function(mode, lhs, rhs)
    vim.api.nvim_buf_set_keymap(0, mode, lhs, rhs, opts)
end

bufremap('n', '[d', '<Cmd>Lspsaga diagnostic_jump_prev<CR>')
bufremap('n', ']d', '<Cmd>Lspsaga diagnostic_jump_next<CR>')

bufremap('n', 'gh',
         '<Cmd>lua require("lspsaga.diagnostic").show_line_diagnostics()<CR>')
bufremap('n', '<leader>fo', '<Cmd>Lspsaga lsp_finder<CR>')
bufremap('n', '<leader>nr', '<Cmd>lua require("lspsaga.rename").rename()<CR>')
