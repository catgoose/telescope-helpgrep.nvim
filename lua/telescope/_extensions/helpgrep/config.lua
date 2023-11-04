local Config = {}

Config.opts = {}
Config.defaults = {
	ignore_paths = {},
}

function Config.setup(opts)
	opts = opts or {}
	Config.opts = vim.tbl_deep_extend("force", Config.defaults, opts)
end

return Config
