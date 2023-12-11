local api = vim.api
local util = require("lspconfig.util")

local quarto_preview = function(opts)
    opts = opts or {}
    local args = opts.args or ""

    local buffer_path = api.nvim_buf_get_name(0)
    local root_dir = util.root_pattern("_quarto.yml")(buffer_path)
    local cmd
    if root_dir then
        cmd = "quarto preview" .. " " .. args
    else
        cmd = "quarto preview '" .. buffer_path .. "'" .. " " .. args
    end

    local output_term = require("toggleterm.terminal").Terminal:new({
        cmd = cmd,
        direction = require("plugins.toggleterm.utils")
            .determine_term_direction()
    })
    output_term:open()
    vim.cmd [[wincmd p]]
    vim.cmd [[stopinsert]]

    api.nvim_create_autocmd({ "QuitPre", "WinClosed" }, {
        buffer = api.nvim_get_current_buf(),
        group = api.nvim_create_augroup("quartoPreview", {}),
        callback = function(_, _)
            output_term:close()
        end,
    })
end

---@type Keymap[]
return {
    { "n", "<leader>r", function() quarto_preview() end }
}
