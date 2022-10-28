-- Predefinitions {{{
local ok, gl = pcall(require, "galaxyline")
if not ok then
	return nil
end

local M = {}

local palette = require("hydrate.palette")

local colors = {
	bg = palette.cursor_grey,
	fg = palette.white,
	red = palette.red,
	tomato = palette.tomato,
	green = palette.green,
	yellow = palette.yellow,
	orange = palette.orange,
	blue = palette.blue,
	purple = palette.purple,
	periwinkle = palette.periwinkle,
	cyan = palette.cyan,
	black = palette.black,

	error = palette.error,
	warn = palette.warn,
	hint = palette.hint,
	info = palette.info
}

local gls = {
	left = {},
	mid = {},
	right = {},
	short_line_left = {},
	short_line_right = {}
}

-- For filename
local function file_readonly()
	if vim.bo.filetype == 'help' then return '' end
	if vim.bo.readonly == true then return '  ' end
	return ''
end

local function get_current_file_name()
	local file = vim.fn.expand('%:t')
	if vim.fn.empty(file) == 1 then return '' end
	if string.len(file_readonly()) ~= 0 then return file .. file_readonly() end
	if vim.bo.modifiable then
		if vim.bo.modified then return file .. '  ' end
	end
	return file .. ' '
end

-- For filetype
local function has_file_type()
	local f_type = vim.bo.filetype
	if not f_type or f_type == '' then
		return false
	end
	return true
end

-- For ViMode
local alias = {
	n = 'NORMAL',
	no = 'OPERATOR-PENDING',

	i = 'INSERT',
	ic = 'INS-COMPLETE',

	c = 'COMMAND',

	v = 'VISUAL',
	V = 'VISUAL LINE',
	[''] = 'VISUAL BLOCK',

	s = 'SELECT',
	S = 'SELECT LINE',
	[''] = 'SELECT BLOCK',

	R = 'REPLACE',
	Rv = 'VIRTUAL REPLACE',

	cv = 'EX',
	ce = 'NORMAL EX',

	r = 'HIT-ENTER',
	rm = '--MORE',
	['r?'] = ':CONFIRM',
	['!'] = 'SHELL',
	t = 'TERMINAL'
}

local mode_color = {
	n = colors.periwinkle,
	no = colors.periwinkle,

	i = colors.green,
	ic = colors.green,

	v = colors.blue,
	[''] = colors.blue,
	V = colors.blue,

	c = colors.purple,

	s = colors.cyan,
	S = colors.cyan,
	[''] = colors.cyan,

	R = colors.tomato,
	Rv = colors.tomato,

	cv = colors.white,
	ce = colors.white,

	r = colors.orange,
	rm = colors.orange,
	['r?'] = colors.orange,

	['!'] = colors.yellow,

	t = colors.yellow
}

local short_line_list = {
	'startify',
	'term',
	'plug',
	'packer'
}

-- }}}

M.init = function()
	local condition = require('galaxyline.condition')

	-- Left {{{
	table.insert(gls.left, {
		ViMode = {
			provider = function()
				vim.api.nvim_command('hi GalaxyViMode guibg=' ..
					mode_color[vim.fn.mode()] .. ' guifg=' .. colors.black .. ' gui=bold')
				return '  ' .. alias[vim.fn.mode()] .. ' '
			end,
			highlight = { colors.red, colors.bg }
		}
	})

	table.insert(gls.left, {
		Space = {
			provider = function()
				return '  '
			end,
			highlight = { 'NONE', colors.bg }
		}
	})

	table.insert(gls.left, {
		FileIcon = {
			provider = 'FileIcon',
			condition = condition.buffer_not_empty,
			highlight = {
				require('galaxyline.provider_fileinfo').get_file_icon,
				colors.bg
			}
		}
	})

	table.insert(gls.left, {
		FileName = {
			provider = get_current_file_name,
			condition = condition.buffer_not_empty,
			highlight = { colors.fg, colors.bg, 'bold' },
		}
	})

	table.insert(gls.left, {
		Space = {
			provider = function()
				return '  '
			end,
			highlight = { 'NONE', colors.bg }
		}
	})

	table.insert(gls.left, {
		GitIcon = {
			provider = function()
				return ''
			end,
			condition = condition.check_git_workspace,
			separator = ' ',
			separator_highlight = { 'NONE', colors.bg },
			highlight = { colors.orange, colors.bg }
		}
	})

	table.insert(gls.left, {
		GitBranch = {
			provider = 'GitBranch',
			condition = condition.check_git_workspace,
			highlight = { colors.orange, colors.bg }
		}
	})

	table.insert(gls.left, {
		Space = {
			provider = function()
				return '   '
			end,
			condition = condition.check_git_workspace,
			highlight = { 'NONE', colors.bg }
		}
	})

	table.insert(gls.left, {
		DiffAdd = {
			provider = 'DiffAdd',
			condition = condition.hide_in_width,
			icon = '  ',
			highlight = { colors.green, colors.bg }
		}
	})

	table.insert(gls.left, {
		DiffModified = {
			provider = 'DiffModified',
			condition = condition.hide_in_width,
			icon = ' 柳',
			highlight = { colors.blue, colors.bg }
		}
	})
	table.insert(gls.left, {
		DiffRemove = {
			provider = 'DiffRemove',
			condition = condition.hide_in_width,
			icon = '  ',
			highlight = { colors.red, colors.bg }
		}
	})
	-- }}}

	-- Right {{{
	table.insert(gls.right, {
		DiagnosticError = {
			provider = 'DiagnosticError',
			icon = '   ',
			highlight = { colors.error, colors.bg }
		}
	})

	table.insert(gls.right, {
		DiagnosticWarn = {
			provider = 'DiagnosticWarn',
			icon = '   ',
			highlight = { colors.warn, colors.bg }
		}
	})

	table.insert(gls.right, {
		DiagnosticHint = {
			provider = 'DiagnosticHint',
			icon = '   ',
			highlight = { colors.hint, colors.bg }
		}
	})

	table.insert(gls.right, {
		DiagnosticInfo = {
			provider = 'DiagnosticInfo',
			icon = '   ',
			highlight = { colors.info, colors.bg }
		}
	})

	table.insert(gls.right, {
		Space = {
			provider = function() return ' ' end,
			highlight = { 'NONE', colors.bg }
		}
	})

	table.insert(gls.right, {
		LineNumber =
		{
			provider = function()
				return vim.fn.line('.') .. '/' .. vim.fn.line('$')
			end,
			icon = ':',
			condition = condition.buffer_not_empty,
			separator = ' ',
			separator_highlight = { 'NONE', colors.periwinkle },
			highlight = { colors.black, colors.periwinkle, 'bold' },
		}
	})
	table.insert(gls.right, {
		ColumnNumber =
		{
			provider = function() return vim.fn.col('.') end,
			icon = ':',
			condition = condition.buffer_not_empty,
			separator = ' ',
			separator_highlight = { 'NONE', colors.periwinkle },
			highlight = { colors.black, colors.periwinkle, 'bold' },
		}
	})

	table.insert(gls.right, {
		SpacePeriwinkle = {
			provider = function() return ' ' end,
			condition = condition.buffer_not_empty,
			highlight = { 'NONE', colors.periwinkle }
		}
	})

	table.insert(gls.right, {
		SpaceBlue = {
			provider = function() return ' ' end,
			condition = condition.buffer_not_empty,
			highlight = { 'NONE', colors.blue }
		}
	})

	table.insert(gls.right, {
		PerCent = {
			provider = 'LinePercent',
			condition = condition.buffer_not_empty,
			highlight = { colors.black, colors.blue, 'bold' }
		}
	})

	table.insert(gls.right, {
		SpaceCyan = {
			provider = function() return ' ' end,
			condition = has_file_type,
			highlight = { 'NONE', colors.cyan }
		}
	})

	table.insert(gls.right, {
		BufferType = {
			provider = 'FileTypeName',
			condition = has_file_type,
			highlight = { colors.black, colors.cyan, 'bold' }
		}
	})

	table.insert(gls.right, {
		SpaceCyan = {
			provider = function() return ' ' end,
			condition = condition.hide_in_width,
			highlight = { 'NONE', colors.cyan }
		}
	})

	table.insert(gls.right, {
		FileEncode = {
			provider = 'FileEncode',
			condition = condition.hide_in_width,
			highlight = { colors.black, colors.cyan, 'bold' }
		}
	})

	table.insert(gls.right, {
		SpaceCyan = {
			provider = function() return ' ' end,
			highlight = { 'NONE', colors.cyan }
		}
	})
	-- }}}

	-- Short left {{{
	table.insert(gls.short_line_left, {
		Space = {
			provider = function()
				return '  '
			end,
			highlight = { 'NONE', colors.bg }
		}
	})

	table.insert(gls.short_line_left, {
		FileIcon = {
			provider = 'FileIcon',
			condition = condition.buffer_not_empty,
			highlight = {
				require('galaxyline.provider_fileinfo').get_file_icon,
				colors.bg
			}
		}
	})
	table.insert(gls.short_line_left, {
		FileName = {
			provider = get_current_file_name,
			condition = condition.buffer_not_empty,
			highlight = { colors.fg, colors.bg, 'bold' },
		}
	})
	-- }}}

	-- Short right {{{
	table.insert(gls.short_line_right, {
		SpaceCyan = {
			provider = function() return ' ' end,
			condition = has_file_type,
			highlight = { 'NONE', colors.cyan }
		}
	})

	table.insert(gls.short_line_right, {
		BufferType = {
			provider = 'FileTypeName',
			condition = has_file_type,
			highlight = { colors.black, colors.cyan, 'bold' }
		}
	})

	table.insert(gls.short_line_right, {
		SpaceCyan = {
			provider = function() return ' ' end,
			condition = condition.hide_in_width,
			highlight = { 'NONE', colors.cyan }
		}
	})

	table.insert(gls.short_line_right, {
		FileEncode = {
			provider = 'FileEncode',
			condition = condition.hide_in_width,
			highlight = { colors.black, colors.cyan, 'bold' }
		}
	})

	table.insert(gls.short_line_right, {
		SpaceCyan = {
			provider = function() return ' ' end,
			highlight = { 'NONE', colors.cyan }
		}
	})
	-- }}}

	gl.section = gls
	gl.short_line_list = short_line_list
end

return M
