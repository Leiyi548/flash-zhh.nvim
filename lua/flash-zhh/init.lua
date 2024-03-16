local flash = require("flash")
local zhh = require("flash-zhh.zhh")

local M = {}

function M.jump(opts)
	opts = vim.tbl_deep_extend("force", {
		-- labels = "123456789;,.[]",
		labels = "ASDFGHJKLQWERTYUIOPZXCVBNM",
		search = {
			mode = M._zh_mode_notify,
		},
		-- behave like `incsearch`
		incremental = false,
		-- 如果有 continue，那么上次的搜索还在，就继续上次搜索。
		continue = false,
	}, opts or {})
	flash.jump(opts)
end

function M.remote(opts)
	opts = vim.tbl_deep_extend("force", {
		labels = "123456789;,.[]",
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
	local ret = zhh.patterns[str]
	if #str > 4 then
		-- vim.notify("虎码搜索字符超过 4 个字符", vim.log.levels.INFO, {
		-- 	icon = "🐯",
		-- 	title = "虎码单字",
		-- })
		return
	else
		if ret == nil then
			-- vim.notify("没有这个字", vim.log.levels.INFO, {
			-- 	icon = "🐯",
			-- 	title = "虎码单字",
			-- })
			return
		end
		-- vim.notify(ret, vim.log.levels.INFO, {
		-- 	icon = "🐯",
		-- 	title = "虎码单字",
		-- })
	end
	return ret
end

function M._zh_mode_notify(str)
	require("noice").cmd("dismiss")
	local ret = zhh.patterns[str]
	if #str > 4 then
		vim.notify("虎码搜索字符超过 4 个字符", vim.log.levels.INFO, {
			icon = "🐯",
			title = "虎码单字",
		})
		return
	else
		if ret == nil then
			vim.notify("没有这个字", vim.log.levels.INFO, {
				icon = "🐯",
				title = "虎码单字",
			})
			return
		end
		vim.notify(ret, vim.log.levels.INFO, {
			icon = "🐯",
			title = "虎码单字",
		})
	end
	return ret
end

return M
