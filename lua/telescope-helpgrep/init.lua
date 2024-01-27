local builtin = require("telescope.builtin")
local config = require("telescope-helpgrep.config")
local mappings = require("telescope-helpgrep.mappings")

local M = {}

local function get_docs_dirs(opts)
	local paths = vim.api.nvim_get_option("runtimepath")
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

function M.picker()
	local dirs = get_docs_dirs(config.opts)
	builtin.live_grep({
		prompt_title = "Help Grep",
		search_dirs = dirs,
    glob_pattern = "*.txt",
    disable_coordinates = true,
    path_display = { "tail", },
    attach_mappings = mappings.open_help_buf,
	})
end

return M
