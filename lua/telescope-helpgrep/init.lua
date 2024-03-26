local builtin = require("telescope.builtin")
local config = require("telescope-helpgrep.config")
local mappings = require("telescope-helpgrep.mappings")

local M = {}

local function get_docs_dirs(opts)
	local paths = vim.api.nvim_get_option_value("runtimepath", { scope = "global" })
	paths = vim.split(paths, ",")
	for i, path in pairs(paths) do
		if opts.ignore_paths and vim.tbl_contains(opts.ignore_paths, path) then
			table.remove(paths, i)
		else
			paths[i] = path .. "/doc"
		end
	end
	return paths
end

local get_opts = function(opts)
	local dirs = get_docs_dirs(config.opts)
	local _opts = {
		prompt_title = "Help Grep",
		search_dirs = dirs,
		glob_pattern = "*.txt",
		disable_coordinates = true,
		path_display = { "tail" },
		attach_mappings = mappings.open_help_buf,
	}
	return vim.tbl_deep_extend("force", _opts, opts or {})
end

M.live_grep = function(opts)
	local _opts = get_opts(opts)
	builtin.live_grep(_opts)
end

M.grep_string = function(opts)
	local _opts = get_opts(opts)
	builtin.live_grep(_opts)
end

return M
