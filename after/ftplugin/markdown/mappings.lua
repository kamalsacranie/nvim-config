local api = vim.api
local util = require("lspconfig.util")

local root_dir_patterns = { "_quarto.yml" }

---@return string?
local markdown_root_dir = function()
    local buffer_path = api.nvim_buf_get_name(0)
    local root_dir = util.root_pattern(root_dir_patterns)(buffer_path)
    return root_dir
end

local quarto_preview = function(opts)
    opts = opts or {}
    local args = opts.args or ""
    local root_dir = markdown_root_dir()
    local cmd
    if root_dir then
        cmd = "quarto preview" .. " " .. args
    else
        cmd = "quarto preview '" ..
            api.nvim_buf_get_name(0) .. "'" .. " " .. args
    end

    local term_cfg = {
        dir = root_dir,
    }

    local term = require("plugins.toggleterm.utils").exec_or_create_term(cmd,
        term_cfg)
    vim.cmd [[wincmd p]]
    vim.cmd [[stopinsert]]
    if not term then
        return
    end
    api.nvim_create_autocmd({ "QuitPre", "WinClosed" }, {
        buffer = api.nvim_get_current_buf(),
        group = api.nvim_create_augroup("quartoPreview", {}),
        callback = function(_, _)
            term:close()
        end,
    })
end

local md_toc = function()
    local query_string = [[(atx_heading)
        [(atx_h1_marker) (atx_h2_marker) (atx_h3_marker) (atx_h4_marker) (atx_h5_marker) (atx_h6_marker)] @level
        heading_content: ((inline) @heading)]]
    local query = vim.treesitter.query.parse("markdown", query_string)
    local parser = vim.treesitter.get_parser(nil, "markdown")
    local tree = parser:parse()[1]:root()
    local headings = {}
    local stage_heading = function(heading_level)
        return function(heading_text, heading_line)
            table.insert(headings,
                {
                    text = string.rep("·   ", heading_level) .. heading_text,
                    lnum =
                        heading_line + 1,
                    bufnr = vim.fn.bufnr(),
                })
        end
    end
    local add_staged_heading = nil
    for _, node, _ in query:iter_captures(tree, 0, 0, -1) do
        if node:type() ~= "inline" then
            local heading_level = string.len(vim.treesitter.get_node_text(node, 0))
            add_staged_heading = stage_heading(heading_level)
            goto continue
        end
        if add_staged_heading == nil then
            error("No heading level found")
        end
        add_staged_heading(vim.treesitter.get_node_text(node, 0), node:range())
        ::continue::
    end
    vim.fn.setqflist(headings, "r")
    local qfbufnr = vim.fn.getqflist({ winid = 0, qfbufnr = 0 })
    vim.cmd("copen")
    vim.api.nvim_set_option_value("conceallevel", 2, { win = qfbufnr["winid"] })
    vim.api.nvim_set_option_value("concealcursor", "niv",
        { win = qfbufnr["winid"] })
    vim.cmd [[syntax match ConcealedDetails /\v^[^|]*\|[^|]*\| / conceal]]
    vim.cmd [[syntax match ConcealBullet /·/ conceal]]
    local qf_mappings = {
        { "n", "<C-p>", function()
            pcall(vim.cmd, "cprev")
            vim.cmd [[wincmd p]]
        end },
        { "n", "<C-n>", function()
            pcall(vim.cmd, "cnext")
            vim.cmd [[wincmd p]]
        end },
        { "n", "<ESC>", function() vim.cmd("cclose") end },
    }
    require("nvim-mapper").map_keymap_list(qf_mappings,
        { buffer = qfbufnr["winid"] })
    vim.api.nvim_create_autocmd("QuitPre", {
        callback = function()
            vim.cmd("cclose")
        end,
    })
end

---@type Keymap[]
return {
    { "n", "<leader>P",   function() quarto_preview() end },
    { "n", "<leader>r", function()
        if vim.fn.executable("quarto") == 1 then
            vim.system({ "quarto", "render", markdown_root_dir() and "" or
            api.nvim_buf_get_name(0) }, { detach = true }, function()
                vim.schedule(function() vim.notify("Quarto render complete") end)
            end)
        else
            vim.notify("No Quarto executable found")
        end
    end },
    { "n", "<leader>toc", md_toc }
}
