local statusline = {
	StatusLineNormal = { fg = C.black, bg = C.periwinkle, style = "bold" },
	StatusLineInsert = { fg = C.black, bg = C.green, style = "bold" },
	StatusLineVisual = { fg = C.black, bg = C.blue, style = "bold" },
	StatusLineCommand = { fg = C.black, bg = C.purple, style = "bold" },
	StatusLineReplace = { fg = C.black, bg = C.tomato, style = "bold" },
	StatusLineTerminal = { fg = C.black, bg = C.yellow, style = "bold" },
	StatusLineMiddle = { fg = C.white, bg = C.cursor_dark_grey },
	StatusLineDefault = { fg = C.white, bg = C.cursor_grey },
	StatusLineEdge = { fg = C.yellow, bg = C.cursor_grey },
}

return statusline;
