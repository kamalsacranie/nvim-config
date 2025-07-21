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

local dispatch = {}
local should_write = true

local augroup = vim.api.nvim_create_augroup("format_on_save_lsp",
    { clear = true })
vim.api.nvim_create_autocmd("LspAttach", {
    group = augroup,
    callback = function(env)
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
            vim.cmd [[write]]
        end

        vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            callback = function()
                if not should_write then
                    return
                end

                if dispatch[bufnr] == nil then
                    dispatch[bufnr] = {}
                end

                table.insert(dispatch[bufnr], vim.schedule_wrap(function()
                    client.request("textDocument/formatting", params,
                        handler,
                        bufnr)
                end))
            end,
        })

        require("nvim-mapper").map_keymap("n", "<leader>ltf",
            function()
                format = not format
                vim.notify(
                    "Format on save " .. (format and "enabled" or "disabled"),
                    "info",
                    {
                        title = "Format on save"
                    })
            end)
    end
})

vim.api.nvim_create_autocmd("BufWritePost", {
    group = augroup,
    callback = function(ev)
        local bufnr = ev.buf
        should_write = false

        local success, cb = pcall(table.remove, dispatch[bufnr])
        if not success then return end
        if cb then
            cb()
        else
            require("utils.helpers").send_keys_to_nvim("zz")
            should_write = true
        end
    end,
})

return M
