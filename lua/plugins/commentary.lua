local setup = function()
	local status_ok, comment = load_package("Comment")
	if not status_ok then
		return
	end

	-- Use treesitter grammar to put in the correct comments
	comment.setup({
		pre_hook = require(
			"ts_context_commentstring.integrations.comment_nvim"
		).create_pre_hook(),
	})
end

-- Commentary
return {
	"numToStr/Comment.nvim",
	config = setup,
	dependencies = "JoosepAlviste/nvim-ts-context-commentstring",
}
