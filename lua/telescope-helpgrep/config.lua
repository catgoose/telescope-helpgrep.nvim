local Config = {}

Config.opts = {}

Config.defaults = {
	ignore_paths = {},
}

function Config.setup(ext_config)
  usr_opts = ext_config or {}
	Config.opts = vim.tbl_deep_extend("force", Config.defaults, usr_opts)
end

return Config

