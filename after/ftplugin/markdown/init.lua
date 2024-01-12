-- syntax match ConcealedDetails /\s\s$/ conceal cchar=·

---@type opts
local md_opts = {
    buf = {
        tabstop = 2,
        softtabstop = 2,
        shiftwidth = 0,
        expandtab = true,
        textwidth = 80,
    },
    win = {
        colorcolumn = "81"
    }
}

local cmp = require("cmp")
local md_cmp = {}

function md_cmp:is_available()
    return true
end

function md_cmp:get_trigger_characters()
    return { "@" }
end

function md_cmp:complete(params, callback)
    vim.system({ "pandoc", "-t", "native" },
        {
            stdin = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, true),
                "\n")
        },
        function(pandoc_out)
            vim.system(
                { "/users/kamalsacranie/.config/nvim/lua/plugins/cmp/markdown-completion" },
                { stdin = pandoc_out.stdout }, function(md_comp_out)
                    local cmp_items = vim.json.decode(md_comp_out.stdout)
                    cmp_items = vim.tbl_map(function(cmp_item)
                        return { label = cmp_item }
                    end, cmp_items)
                    callback(cmp_items)
                end)
        end)
end

cmp.register_source("md_cmp", md_cmp)

require("utils.spell")

require("utils.options").set_all_options(md_opts)

require("nvim-mapper").map_keymap_list(require("ftplugin.markdown.mappings"),
    { buffer = true })
