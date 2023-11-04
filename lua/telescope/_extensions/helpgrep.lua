local has_telescope, telescope = pcall(require, "telescope")

if not has_telescope then
	error("This extension requires 'telescope.nvim'. (https://github.com/nvim-telescope/telescope.nvim)")
end

local config = require("telescope._extensions.helpgrep.config")
local picker = require("telescope._extensions.helpgrep.picker")

return telescope.register_extension({
	setup = config.setup,
	exports = {
		helpgrep = picker.helpgrep,
	},
})
