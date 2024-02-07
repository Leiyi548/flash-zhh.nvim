local flash = require("flash")
local zhh = require("flash-zhh.zhh")

local M = {}

function M.jump(opts)
	opts = vim.tbl_deep_extend("force", {
		labels = "ASDFGHJKLQWERTYUIOPZXCVBNM",
		search = {
			mode = M._zh_mode,
		},
	}, opts or {})
	flash.jump(opts)
end

function M._zh_mode(str)
	local regexs = {}
	if string.len(str) == 1 then
		regexs[#regexs + 1] = zhh.char1patterns[str]
	end
	if string.len(str) == 2 then
		regexs[#regexs + 1] = zhh.char2patterns[str]
	end
	if string.len(str) == 3 then
		regexs[#regexs + 1] = zhh.char3patterns[str]
	end
	if string.len(str) == 4 then
		regexs[#regexs + 1] = zhh.char4patterns[str]
	end
	local ret = table.concat(regexs)
	return ret, ret
end

return M
