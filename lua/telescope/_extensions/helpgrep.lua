local has_telescope, telescope = pcall(require, "telescope")

if not has_telescope then
	error("This extension requires 'telescope.nvim'. (https://github.com/nvim-telescope/telescope.nvim)")
end

local helpgrep = require("telescope-helpgrep")
local config = require("telescope-helpgrep.config")

return telescope.register_extension({
	setup = config.setup,
	exports = {
		helpgrep = config.opts.default_grep or helpgrep.grep_string,
		live_grep = helpgrep.live_grep,
		grep_string = helpgrep.grep_string,
	},
})
