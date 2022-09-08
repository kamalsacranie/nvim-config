local M = {}

M.pretty_fold = function()
    local pf_did_load, pretty_fold = load_package("pretty-fold")
    if not pf_did_load then
        return
    end
    pretty_fold.setup({
        sections = {
            left = {
                "content",
                "╟",
            }, -- auto expands to the content line of the fold
            right = {
                " ",
                "number_of_folded_lines", -- displays number of folded lines
                " ",
                function(config)
                    return config.fill_char:rep(3)
                end,
                "╮",
            },
        },
        fill_char = "─",
    })
end

-- The mapping setup for this is located in the lsp_map file
-- Setting up pretty fold
M.fold_preview =  function()
    local fp_did_load, fold_preview = load_package("fold-preview")
    if not fp_did_load then
        return
    end
    fold_preview.setup({
        border = "shadow",
    })
end



return M
