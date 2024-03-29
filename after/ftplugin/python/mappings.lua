local python_exec_terms = {}

---@type Keymap[]
return {
    { "n", "<leader>r", function(_)
        local pyright_client = vim.lsp.get_clients({ name = "pyright" })[1]
        local python_path = pyright_client.config.settings.python.pythonPath or
            "python"
        local cmd = python_path ..
            " " .. vim.fn.escape(vim.fn.expand("%:p"), " ")

        ---@type TermCreateArgs
        local term_cfg = {
            dir = pyright_client.config.root_dir or vim.fn.getcwd(),
            direction = require("plugins.toggleterm.utils")
                .determine_term_direction(),
            on_open = require("plugins.toggleterm.setup").map_term_nav_keys
        }
        require("plugins.toggleterm.utils").exec_or_create_term(cmd, term_cfg,
            cmd)
    end }
}
