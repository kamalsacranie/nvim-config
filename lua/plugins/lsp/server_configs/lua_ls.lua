return {
    on_init = function(client)
        local path = client.workspace_folders[1].name
        if not vim.loop.fs_stat(path .. "/.luarc.json") and not vim.loop.fs_stat(path .. "/.luarc.jsonc") then
            client.config.settings = vim.tbl_deep_extend("force",
                client.config.settings, {
                    Lua = {
                        diagnostics = {
                            disable = { "missing-fields" },
                            globals = { "vim" },
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
                            enable = true,
                            defaultConfig = {
                                indent_style = "space",
                                indent_size = "4",
                                quote_style = "double",
                                max_line_length = "80",
                                call_arg_parentheses = "keep",
                            },
                        },
                    },
                })

            client.notify("workspace/didChangeConfiguration",
                { settings = client.config.settings })
        end
        return true
    end,
}
