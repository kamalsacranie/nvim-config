local ts_did_load, _ = load_package("nvim-treesitter")
if not ts_did_load then return end

require("user.treesitter.settings.autoparis")
require("user.treesitter.settings.autotag")
require("user.treesitter.settings.context-comments")
require("user.treesitter.settings.matchup")
require("user.treesitter.settings.playground")
require("user.treesitter.settings.rainbow-brackets")
require("user.treesitter.settings.treesitter")
