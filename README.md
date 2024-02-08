# flash-zhh.nvim

## 为什么叫 zhh.nvim

zhh 在虎码中打出来是虎！所以叫 zhh.nvim

基于[flash.nvim](https://github.com/folke/flash.nvim) 和 [虎码](https://tiger-code.com/)，neovim 中文跳转插件。

![iShot_2023-10-05_19 32 53](https://github.com/rainzm/flash-zh.nvim/assets/22927169/4c3ca124-0fee-48a2-b7c6-17391afe8d0e)


## 安装

- 依赖于[flash.nvim](https://github.com/folke/flash.nvim)
- 使用 [lazy.nvim](https://github.com/folke/lazy.nvim) 进行安装:
```lua
return {
	{
		"Leiyi548/flash-zhh.nvim",
		event = "VeryLazy",
		dependencies = "folke/flash.nvim",
		keys = {
			{
				"S",
				mode = { "n", "x", "o" },
				function()
					require("flash-zh").jump()
				end,
				desc = "Flash between Chinese",
			},
		},
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {
			highlight = {
				backdrop = false,
				matches = false,
			},
		},
    }
}
```

## 使用

label 使用大写字母，这样可以避免和拼音冲突。

**如果想要跳转的地方没有 label 出现，接着输入即可，和查找一样。**

## 缺点

- 只能搜索一个字，不能连续搜索。（后续尝试优化）

## 感谢

- [hop-zh-by-flypy](https://github.com/zzhirong/hop-zh-by-flypy)
- [flash-zh.nvim](https://github.com/rain-zm/flash-zh)

## 推荐

- [rime-ls](https://github.com/wlh320/rime-ls) 通过补全的方式输入中文
