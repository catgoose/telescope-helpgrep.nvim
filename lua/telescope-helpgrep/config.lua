local actions = require("telescope.actions")
local builtin = require("telescope.builtin")

local M = {}

M.opts = {}

M.defaults = {
	ignore_paths = {},
	mappings = {
		i = {
			["<CR>"] = actions.select_tab,
		},
		n = {
			["<CR>"] = actions.select_tab,
		},
	},
	default_grep = builtin.grep_string,
}

function M.setup(config)
	config = config or {}
	M.opts = vim.tbl_deep_extend("force", M.defaults, config)
end

return M
