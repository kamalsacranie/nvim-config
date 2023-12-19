local get_python_path = function(lsp_root_dir)
    if vim.env.VIRTUAL_ENV then -- if venve is active
        return require("lspconfig.util").path.join(vim.env.VIRTUAL_ENV ..
            "/bin/python")
    end
    local result = vim.fs.find({ ".venv", "poetry.lock", "Pipfile" },
        {
            upward = false,
            path = lsp_root_dir
        })
    local roots_found = vim.tbl_map(function(v)
        return vim.fs.basename(v)
    end, result)
    if vim.tbl_contains(roots_found, ".venv") then
        return require("lspconfig.util").path.join(result[1], "bin", "python")
    elseif vim.tbl_contains(roots_found, "poetry.lock") then
        return require("lspconfig.util").path.join(
            vim.fn.trim(vim.fn.system("poetry env info -p")), "bin",
            "python")
    elseif vim.tbl_contains(roots_found, "Pipfile") then
        return require("lspconfig.util").path.join(
            vim.fn.trim(vim.fn.system("PIPENV_PIPFILE=" ..
                lsp_root_dir .. " pipenv --venv")), "venv", "bin",
            "python")
    end

    return "python"
end

return {
    on_init = function(client)
        client.config.settings = vim.tbl_deep_extend("force",
            client.config.settings, {
                python = { pythonPath = get_python_path(client.config.root_dir) }
            })

        client.notify("workspace/didChangeConfiguration",
            { settings = client.config.settings })
        return true
    end,
    root_dir = function(fname)
        local util = require("lspconfig.util")
        return util.root_pattern({ ".venv", "poetry.lock", "Pipfile", ".git" })(
            fname
        ) or util.path.dirname(fname)
    end,

}
