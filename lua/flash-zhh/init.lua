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
			restore = false,
			motion = false,
		},
		-- 如果有 continue，那么上次的搜索还在，就继续上次搜索。
		continue = false,
	}, opts or {})
	flash.jump(opts)
end

function M._zh_mode(str)
	require("noice").cmd("dismiss")
	local regexs = {}
	-- while string.len(str) > 3 then
	-- 	-- 当我们输入4个字符的时候，agti → 装
	-- 	-- 当我们输入5个字符的时候，比如 agtit，那么就会先把 regexs[4] = agti|装 弄上
	-- 	-- 后面就会截取只剩 t，再进行 1 个字符区配。
	-- 	regexs[#regexs + 1] = zhh.char4patterns[string.sub(str,1,4)]
	-- 	-- 4 个字符不足 5，获得空字符
	-- 	str = string.sub(str,5)
	-- end
	-- 如果只有一个字符，那么就直接拿这个字符去区配
	while string.len(str) > 1 do
		-- 如果这个时候，我们输入两个字符，那么也是直接区配
		if string.len(str) == 2 then
			-- 假如我要区配 他
			-- 那么我就是输入 je
			-- regexs[2] = [[\%(je\|[他]\)]]
			-- 就是区配 je 或 他
			regexs[#regexs + 1] = zhh.patterns[string.sub(str, 1, 2)]
			vim.notify(vim.inspect(regexs), vim.log.levels.INFO, {
				icon = "🐯",
				title = "虎码",
			})
		end
		if string.len(str) == 3 then
			regexs[#regexs + 1] = zhh.patterns[string.sub(str, 1, 3)]
			vim.notify(vim.inspect(regexs), vim.log.levels.INFO, {
				icon = "🐯",
				title = "虎码",
			})
		end
		if string.len(str) == 4 then
			regexs[#regexs + 1] = zhh.patterns[string.sub(str, 1, 4)]
			vim.notify(vim.inspect(regexs), vim.log.levels.INFO, {
				icon = "🐯",
				title = "虎码",
			})
		end
		str = string.sub(str, 5)
		-- 如果超过五个就退出 flash-zhh.nvim
	end
	if string.len(str) == 1 then
		-- #regexs 代表的是长度
		-- 这个时候 #regexs 代表是0，那么 #regexs + 1 = 1
		regexs[#regexs + 1] = zhh.patterns[str]
		vim.notify(vim.inspect(regexs), vim.log.levels.INFO, {
			icon = "🐯",
			title = "虎码",
		})
		-- 假如区配 “我”，注意 lua 数组是从 1 开始
		-- regexs[1] = [[\%([t我]\)]]
		-- 就是区配 t 或 我
	end
	local ret = table.concat(regexs)
	return ret, ret
end

return M
