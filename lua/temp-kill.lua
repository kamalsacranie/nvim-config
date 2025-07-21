vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = "*.kl",
    callback = function()
        vim.cmd([[set filetype=kill]])
    end,
    desc = "Kamal's intuitive linear language",
})
---@class parser_config
local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.kill = {
    install_info = {
        url =
        "/Users/kamalsacranie/Code/dissertation/tree-sitter-kill",
        files = { "src/parser.c", },
        branch = "main",
        generate_requires_npm = false,
        requires_generate_from_grammar = false,
    },
    filetype = "kill",
}
