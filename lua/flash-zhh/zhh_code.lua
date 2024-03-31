local log = require("flash-zh.dev").log
local zhh_reverse = require("flash-zhh.zhh_reverse")
local M = {}
local cclib = {
	utf8 = {},
}
local utf8 = cclib.utf8
function cclib.GetCharSize(char) --获取单个字符长度
	if not char then
		return 0
	elseif char > 240 then
		return 4
	elseif char > 225 then
		return 3
	elseif char > 192 then
		return 2
	else
		return 1
	end
end

--获取中文字符长度
function cclib.utf8.len(str)
	local len = 0
	local currentIndex = 1
	while currentIndex <= #str do
		local char = string.byte(str, currentIndex)
		currentIndex = currentIndex + cclib.GetCharSize(char)
		len = len + 1
	end
	return len
end

function cclib.utf8.sub(str, startChar, numChars) --截取中文字符串
	local startIndex = 1
	while startChar > 1 do
		local char = string.byte(str, startIndex)
		startIndex = startIndex + cclib.GetCharSize(char)
		startChar = startChar - 1
	end

	local currentIndex = startIndex

	while numChars > 0 and currentIndex <= #str do
		local char = string.byte(str, currentIndex)
		currentIndex = currentIndex + cclib.GetCharSize(char)
		numChars = numChars - 1
	end

	return string.sub(str, startIndex, currentIndex - 1)
end

function M.getZhhCode(chars, separator)
	separator = separator or " "
	log.debug("===start zhhcode===")
	log.debug("chars:" .. chars)
	local zhhcode = {}
	for i = 1, utf8.len(chars) do
		local char = utf8.sub(chars, i, 1)
		log.debug("char:" .. char)
		log.debug("string.len(char):" .. string.len(char))
		--要寻找的字符串
		if string.len(char) == 1 then
			-- 如果就一个字符，比如 a
			-- ["a"] = [[\%([a哀矮癌澳瑷案岸廒暧氨遨嗳璈鏖啊碍骜盦毐皑翱嗄爱鳌蔼𩽾媪暗嗌盎岙按谙桉犴卬螯凹埯铵砹腌隘唉鹌傲鏊聱阿埃锿昂熬黯安胺袄吖叆隩嗷嫒庵垵拗锕敖挨獒哎唵奡奥懊坳鞍欸肮艾霭俺]\)]],
			zhhcode[i] = char
		else
			-- 代表这是中文字符 比如阿
			-- ["aa"] = [[\%(aa\|[阿腌锕啊嗄吖]\)]],
			-- zhhcode[i] = pyTable[阿] = aa
			-- 如果这里要是虎码
			-- 比如 虎→zhh
			-- zhhTable[虎] = zhh
			zhhcode[i] = zhh_reverse.patterns[char]
		end
	end
	log.debug("===end zhhcode===")
	return table.concat(zhhcode, separator)
end

return M
