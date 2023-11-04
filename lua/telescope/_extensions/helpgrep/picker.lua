local builtin = require("telescope.builtin")

local Picker = {}

local function get_docs_dirs()
	local paths = vim.api.nvim_get_option("runtimepath")
	paths = vim.split(paths, ",")
	for i, path in pairs(paths) do
		if path == vim.fn.stdpath("state") .. "/lazy/readme" then
			table.remove(paths, i)
		else
			paths[i] = path .. "/doc"
		end
	end
	return paths
end

function Picker.helpgrep()
	local dirs = get_docs_dirs()
	builtin.live_grep({
		prompt_title = "Helpgrep",
		search_dirs = dirs,
	})
end

return Picker
