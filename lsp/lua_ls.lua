local lua_settings = {
    workspace = {
        checkThirdParty = false,
        library = vim.api.nvim_get_runtime_file("", true),
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
}

return {
    on_init = function(client)
        if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if
                path ~= vim.fn.stdpath("config")
                and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
            then
                return
            end
        end

        client.config.settings.Lua = vim.tbl_deep_extend(
            "force",
            client.config.settings.Lua,
            lua_settings
        )
    end,
    settings = { Lua = {} }
}
