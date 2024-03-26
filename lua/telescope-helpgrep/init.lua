local builtin = require("telescope.builtin")
local config = require("telescope-helpgrep.config")
local mappings = require("telescope-helpgrep.mappings")

local M = {}

local function docs_dirs(opts)
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

local function build_opts(opts)
	local dirs = docs_dirs(config.opts)
	local _opts = {
		prompt_title = "Help Grep",
		glob_pattern = "*.txt",
		disable_coordinates = true,
		path_display = { "tail" },
	}
	_opts = vim.tbl_deep_extend("force", _opts, opts or {})
	_opts = vim.tbl_deep_extend("force", _opts, {
		search_dirs = dirs,
		attach_mappings = mappings.open_help_buf,
	})
	return _opts
end

function M.live_grep(opts)
	local _opts = build_opts(opts)
	builtin.live_grep(_opts)
end

function M.grep_string(opts)
	local _opts = build_opts(opts)
	builtin.grep_string(_opts)
end

return M
