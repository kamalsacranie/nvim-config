local neogen_did_load, neogen = load_package("neogen")
if not neogen_did_load then
	return
end

local defaults = { enable = true }

neogen.setup(EXTEND_CONFIG(defaults, "neogen_config_extend"))
