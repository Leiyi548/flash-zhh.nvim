local flash = require("flash")
local zhh = require("flash-zhh.zhh")

local M = {}

function M.jump(opts)
	opts = vim.tbl_deep_extend("force", {
		labels = "asdfghjklqwertyuiopzxcvbnm",
		search = {
			mode = M._zh_mode,
		},
	}, opts or {})
	flash.jump(opts)
end

function M._zh_mode(str)
	local regexs = {}
	while string.len(str) > 1 do
		regexs[#regexs + 1] = zhh.char2patterns[string.sub(str, 1, 2)]
		str = string.sub(str, 3)
	end
	if string.len(str) == 1 then
		regexs[#regexs + 1] = zhh.char1patterns[str]
	end
	local ret = table.concat(regexs)
	return ret, ret
end

return M
