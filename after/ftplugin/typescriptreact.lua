local M = rerequire("filetype.ts")

local ls = require("luasnip")
table.insert(M.snippet_types, "typescript")
ls.filetype_extend("typescriptreact", M.snippet_types)

return M
