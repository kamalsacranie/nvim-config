---@type LazySpec
return {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
        local pairs = require("nvim-autopairs")
        pairs.setup(
            { enable_check_bracket_line = false, enable_moveright = true, }
        )
        pairs.clear_rules()
        local rule = require("nvim-autopairs.rule")
        local conds = require("nvim-autopairs.conds")
        pairs.add_rule(rule("*", "*", { "markdown" })
            :with_pair(conds.not_before_text [[\]]))
    end,
}
