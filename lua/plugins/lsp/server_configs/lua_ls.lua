local fallback_defaults = {
    Lua = {
        diagnostics = {
            disable = { "missing-fields" },
            neededFileStatus = {
                ["codestyle-check"] = "Any",
            },
        },
        workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false,
        },
        runtime = {
            version = "LuaJIT",
        },
        telemetry = {
            enable = false,
        },
        format = {
            enable = false,
            defaultConfig = {
                indent_style = "space",
                indent_size = "4",
                quote_style = "double",
                max_line_length = "80",
                call_arg_parentheses = "keep",
            },
        },
    },
}

return {
    on_init = function(client)
        local path = type(client.workspace_folders) == "table" and
            client.workspace_folders[1].name or vim.fn.getcwd()
        if not vim.uv.fs_stat(path .. "/.luarc.json") and not vim.uv.fs_stat(path .. "/.luarc.jsonc") then
            client.config.settings = vim.tbl_deep_extend("force",
                client.config.settings, fallback_defaults)

            client.notify("workspace/didChangeConfiguration",
                { settings = client.config.settings })
        end
        return true
    end,
}
