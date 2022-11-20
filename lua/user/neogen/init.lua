local neogen_did_load, neogen = load_package("neogen")
if not neogen_did_load then
	return
end

local defaults = { enable = true }

-- perhapse think about making this global becuase we use it in ts, image_copy, and here
local filetype_opts = function()
	-- Load "filetype.<ft>" which returns M which may have a ts_config table
	local success, ft = pcall(require, "filetype" .. "." .. get_filetype())
	if success then
		return ft.neogen
	end
	return {}
end

-- Dynamically generating opts based on what is in our ftplugin file to reduce coupling with ts
local generate_options = function()
	return vim.tbl_extend("force", defaults, filetype_opts() or {})
end

neogen.setup(generate_options())
