-- Thanks ThePrimeagen
local M = {}

M.log = require("plenary.log").new({
	plugin = "flash-zhh",
	level = "debug",
	usefile = true,
	-- Should print the output to neovim while running.
	-- values: 'sync','async',false
	use_console = false,
})

return M
