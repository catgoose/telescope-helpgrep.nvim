local M = {}

M.opts = {}

M.defaults = {
	ignore_paths = {},
}

function M.setup(config)
	config = config or {}
	M.opts = vim.tbl_deep_extend("force", M.defaults, config)
end

return M
