local HelpGrep = {}

HelpGrep.opts = {}
local defaults = {}

function HelpGrep.setup(opts)
	opts = opts or {}
	HelpGrep.opts = vim.tbl_deep_extend("force", defaults, opts)
end

return HelpGrep
