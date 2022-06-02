local is_loaded, _ = LOAD_PACKAGE("nvim-treesitter.configs")
if not is_loaded then
	return
end

require("user.treesitter.autoparis")
require("user.treesitter.autotag")
require("user.treesitter.context-comments")
require("user.treesitter.matchup")
require("user.treesitter.playground")
require("user.treesitter.rainbow-brackets")
require("user.treesitter.treesitter")
