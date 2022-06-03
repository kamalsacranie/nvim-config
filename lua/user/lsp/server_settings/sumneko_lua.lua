return {
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                library = {
                    -- [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.stdpath("config") .. "/lua"] = true,
                    vim.api.nvim_get_runtime_file("", true),
                },
            },
            telemetry = {
                enable = false,
            },
        },
    },
}
