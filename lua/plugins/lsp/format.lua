local M = {}

function M.ranged_format(fallback)
    local coords = require("utils.helpers").get_visual_selection_coordinates()
    if not coords then
        return
    end
    -- this is in the case we aren't using the LSP to format but rather a
    -- different formatter
    if fallback then
        return fallback(coords)
    end
    vim.lsp.buf.format({
        async = true,
        range = {
            start = { coords.start_row, coords.start_col },
            ["end"] = { coords.end_row, coords.end_col }
        }
    })
end

local augroup = vim.api.nvim_create_augroup("format_on_save_lsp",
    { clear = true })
vim.api.nvim_create_autocmd("LspAttach", {
    group = augroup,
    callback = function(env)
        local writing = false
        local format = true
        local bufnr = env.buf
        local client = vim.lsp.get_client_by_id(env.data.client_id)
        if client == nil then
            return
        end

        if not client.server_capabilities.documentFormattingProvider then
            return
        end

        local params = vim.lsp.util.make_formatting_params({})
        local handler = function(err, result, _)
            if err ~= nil or result == nil then
                return
            end
            vim.lsp.util.apply_text_edits(result, bufnr, client.offset_encoding)
            writing = true
            vim.cmd [[write]]
            -- center the screen (would have to change this if I ever dont have curline centered)
            require("utils.helpers").send_keys_to_nvim("zz")
            writing = false
        end

        vim.api.nvim_create_autocmd("BufWritePost", {
            group = augroup,
            callback = function()
                if vim.fn.bufnr() ~= bufnr or writing or not format then
                    return
                end
                client.request("textDocument/formatting", params, handler,
                    bufnr)
            end,
        })

        require("nvim-mapper").map_keymap("n", "<leader>ltf",
            function() format = false end)
    end
})

return M
