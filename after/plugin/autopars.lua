local autopairs = require "nvim-autopairs"
local Rule = require "nvim-autopairs.rule"
local cond = require "nvim-autopairs.conds"
if package.loaded["cmp"] then
    require("nvim-autopairs.completion.cmp").setup {
        map_cr = false, -- indent when you return on two brackets
        map_complete = true, -- Complete the parenthesis
        auto_select = true, -- Dont autoselect form the pum
        insert = true, -- Insert your completion instead of replacing
        map_char = {all = '(', tex = '{'} -- specific completion char for latex
    }
end
-- Setting up treesitter. Should change all to wrok like this
require("nvim-treesitter.configs").setup {autopairs = {enable = true}}
-- Calling the plugin
require('nvim-autopairs').setup {}
-- autopairs.add_rule(Rule("$$", "$$", {"tex", "latex", "markdown", "rmarkdown"}))
autopairs.add_rules {
    Rule("$", "$", {"tex", "latex", "markdown", "rmarkdown"}) -- don't add a pair if the next character is %
    :with_pair(cond.not_after_regex_check "%%") -- don't add a pair if  the previous character is xxx
    :with_pair(cond.not_before_regex_check("xxx", 3)) -- don't move right when repeat character
    :with_move(cond.none()) -- don't delete if the next character is xx
    :with_del(cond.not_after_regex_check "xx") -- disable  add newline when press <cr>
    :with_cr(cond.none())
}
