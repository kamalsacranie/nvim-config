local M = rerequire("filetype.javascript")

local ls = require("luasnip")
table.insert(M.snippet_types, "javascript")
ls.filetype_extend("javascriptreact", M.snippet_types)

return M
