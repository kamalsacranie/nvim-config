local status_ok, comment = load_package("comment")
if not status_ok then
	return
end

comment.setup({
	-- this prehook is tacken from their readme. it intergrates with
	-- ts_context_commentstring
	pre_hook = function(ctx)
		-- linking in our context_comments plugin
		require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()
		local u = require("comment.utils")

		-- local type = ctx.ctype == u.ctype.linewise and "__default" or "__multiline"
		local location = nil
		if ctx.ctype == u.ctype.blockwise then
			location =
				require("ts_context_commentstring.utils").get_cursor_location()
		elseif ctx.cmotion == u.cmotion.v or ctx.cmotion == u.cmotion.v then
			location =
				require("ts_context_commentstring.utils").get_visual_start_location()
		end

		return require("ts_context_commentstring.internal").calculate_commentstring({
			key = ctx.ctype == u.ctype.line and "__default" or "__multiline",
			location = location,
		})
	end,
})
