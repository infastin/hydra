local function hi(group, props)
	local bg = props.bg == nil and "guibg=NONE" or "guibg=" .. props.bg
	local fg = props.fg == nil and "guifg=NONE" or "guifg=" .. props.fg
	local style = props.style == nil and "gui=NONE" or "gui=" .. props.style
	local link = props.link

	if vim.fn.has("nvim-0.8") == 1 then
		group = props.group == nil and group or props.group
	end

	local cmd = nil

	if link == nil then
		cmd = table.concat({
			"hi",
			group,
			bg,
			fg,
			style,
		}, " ")
	else
		cmd = table.concat({
			"hi",
			"link",
			group,
			link
		}, " ")
	end

	vim.cmd(cmd)
end

vim.api.nvim_command("hi clear")

if vim.fn.exists "syntax_on" then
	vim.api.nvim_command("syntax reset")
end

vim.o.termguicolors = true
vim.g.colors_name = "hydrate"

C = require("hydrate.palette")

local lang = Hydra.require.tree("hydrate.lang")
local base = Hydra.require.tree("hydrate.base")
local plugins = Hydra.require.tree("hydrate.plugins")

local skels_group = {
	lang,
	base,
	plugins
}

for _, skels in pairs(skels_group) do
	for _, skel in pairs(skels) do
		for group, props in pairs(skel) do
			hi(group, props)
		end
	end
end

vim.o.background = "dark"
