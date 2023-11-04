local builtin = require("telescope.builtin")

local Picker = {}

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

function Picker.helpgrep()
	local opts = require("telescope._extensions.helpgrep.config").opts
	local dirs = get_docs_dirs(opts)
	builtin.live_grep({
		prompt_title = "Help Grep",
		search_dirs = dirs,
	})
end

return Picker
