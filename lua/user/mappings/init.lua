local M = {}

-- Mappings that simply need to be run to setup
require("user.mappings.telescope_map")
require("user.mappings.ultisnips_map")
require("user.mappings.general_vim_map")
require("user.mappings.pretty_fold_map")
require("user.mappings.filetree_map")

-- Returning mappings that we dont want to automatically execute
M.cmp = require("user.mappings.cmp_map")

return M
