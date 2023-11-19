local M = {}

function M.ranged_format()
    local coords = require("utils.helpers").get_visual_selection_coordinates()
    if not coords then
        return
    end
    vim.lsp.buf.format({
        async = true,
        range = {
            start = { coords.start_row, coords.start_row },
            ["end"] = { coords.end_row, coords.end_col }
        }
    })
end

-- Autoformat toggle from chris@machine
function M.enable_format_on_save()
    vim.cmd([[
    augroup format_on_save
      autocmd!
      autocmd BufWritePre * lua vim.lsp.buf.format { async = true }
    augroup end
  ]])
end

function M.disable_format_on_save()
    M.remove_augroup("format_on_save")
    vim.notify("Disabled format on save")
end

function M.toggle_format_on_save()
    if vim.fn.exists("#format_on_save#BufWritePre") == 0 then
        M.enable_format_on_save()
        vim.notify("Enabled format on save")
    else
        M.disable_format_on_save()
    end
end

function M.remove_augroup(name)
    if vim.fn.exists("#" .. name) == 1 then
        vim.cmd("au! " .. name)
    end
end

vim.cmd(
    [[ command! LspToggleAutoFormat execute 'lua require("plugins.lsp.format").toggle_format_on_save()' ]]
)

return M
