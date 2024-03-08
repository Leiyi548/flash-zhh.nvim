local flash = require("flash")
local zhh = require("flash-zhh.zhh")

local M = {}

function M.jump(opts)
	opts = vim.tbl_deep_extend("force", {
		labels = "123456789;,.[]",
		search = {
			mode = M._zh_mode,
		},
		remote_op = {
			restore = true,
			motion = true,
		},
		-- behave like `incsearch`
		incremental = true,
		-- 如果有 continue，那么上次的搜索还在，就继续上次搜索。
		continue = false,
	}, opts or {})
	flash.jump(opts)
end

function M._zh_mode(str)
	require("noice").cmd("dismiss")
	local regexs = {}
	-- #regexs 代表的是长度
	-- 这个时候 #regexs 代表是0，那么 #regexs + 1 = 1
	regexs[#regexs + 1] = zhh.patterns[str]
	local ret = table.concat(regexs)
	vim.notify(vim.inspect(ret), vim.log.levels.INFO, {
		icon = "🐯",
		title = "虎码",
	})
	return ret
end

return M
