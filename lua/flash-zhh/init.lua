local flash = require("flash")
local zhh = require("flash-zhh.zhh")
local log = require("flash-zhh.dev").log

local M = {}

function M.jump(opts)
	opts = vim.tbl_deep_extend("force", {
		-- labels = "123456789;,.[]",
		labels = "asdfghjklqwertyuiopzxcvbnm",
		search = {
			mode = M._zh_mode,
		},
		labeler = function(_, state)
			require("flash-zhh.labeler").new(state):update()
		end,
		-- behave like `incsearch`
		incremental = false,
		-- 如果有 continue，那么上次的搜索还在，就继续上次搜索。
		continue = false,
		remote_op = {
			restore = true,
			motion = true,
		},
	}, opts or {})
	flash.jump(opts)
end

function M.remote(opts)
	opts = vim.tbl_deep_extend("force", {
		labels = "asdfghjklqwertyuiopzxcvbnm",
		-- labels = "ASDFGHJKLQWERTYUIOPZXCVBNM",
		search = {
			mode = M._zh_mode,
		},
		remote_op = {
			restore = true,
			motion = true,
		},
		-- behave like `incsearch`
		incremental = false,
		-- 如果有 continue，那么上次的搜索还在，就继续上次搜索。
		continue = false,
	}, opts or {})
	flash.jump(opts)
end

function M._zh_mode(str)
	local regexs = {}
	if #str == 1 then
		return zhh.onepattern[str]
	elseif #str <= 4 then
		if zhh.patterns[str] == nil then
			return str
		else
			return zhh.patterns[str]
		end
	else
		return str
	end
end

return M
