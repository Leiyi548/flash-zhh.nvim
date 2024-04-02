local flash = require("flash")
local zhh = require("flash-zhh.zhh")
local Config = require("flash.config")
-- local log = require("flash-zhh.dev").log

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

function M._zh_onechar_mode(motion)
	---@param c string
	return function(c)
		c = c:gsub("\\", "\\\\")
		local pattern ---@type string
		if motion == "t" then
			pattern = "\\m.\\ze\\V" .. c
		elseif motion == "T" then
			pattern = "\\V" .. c .. "\\zs\\m."
		else
			pattern = "\\V" .. c
		end
		if not Config.get("char").multi_line then
			local pos = vim.api.nvim_win_get_cursor(0)
			pattern = ("\\%%%dl"):format(pos[1]) .. pattern
		end

		return pattern
	end
	-- return zhh.onepattern[motion]
end

return M
