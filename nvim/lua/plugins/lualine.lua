local ok, lualine = pcall(require, "lualine")
if not ok then
	return nil
end

local theme = {
	normal = {
		a = "StatusLineNormal",
		b = "StatusLineMiddle",
		c = "StatusLineEdge",
	},
	insert = {
		a = "StatusLineInsert",
		b = "StatusLineMiddle",
		c = "StatusLineEdge",
	},
	visual = {
		a = "StatusLineVisual",
		b = "StatusLineMiddle",
		c = "StatusLineEdge",
	},
	replace = {
		a = "StatusLineReplace",
		b = "StatusLineMiddle",
		c = "StatusLineEdge",
	},
	command = {
		a = "StatusLineCommand",
		b = "StatusLineMiddle",
		c = "StatusLineEdge",
	},
	terminal = {
		a = "StatusLineTerminal",
		b = "StatusLineMiddle",
		c = "StatusLineEdge",
	},
	inactive = {
		a = "StatusLineDefault",
		b = "StatusLineDefault",
		c = "StatusLineDefault",
	}
}

local M = {
	options = {
		icons_enabled = true,
		theme = theme,
		component_separators = { left = "", right = ""},
		section_separators = { left = "", right = ""},
	},
	sections = {
		lualine_a = {"mode"},
		lualine_b = {"filename"},
		lualine_c = {"branch", "diff"},
		lualine_x = {"g:coc_status", "diagnostics"},
		lualine_y = {"encoding", "filetype"},
		lualine_z = {"location"},
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {"filename"},
		lualine_c = {},
		lualine_x = {"diagnostics"},
		lualine_y = {"encoding", "filetype"},
		lualine_z = {"location"}
	},
}

M.init = function()
	lualine.setup(M)
end

return M
