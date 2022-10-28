local dap = {
	DapUIVariable = { fg = C.white },
	DapUIScope = { fg = C.cyan, style = "bold" },
	DapUIThread = { style = "bold" },
	DapUIStoppedThread = { fg = C.cyan, style = "bold" },
	DapUISource = { fg = C.green },
	DapUIFrameName = { fg = C.white },
	DapUILineNumber = { style = "bold" },
	DapUIBreakpointsPath = { fg = C.cyan, style = "bold" },
	DapUIBreakpointsInfo = { fg = C.white },
	DapUIBreakpointsCurrentLine = { style = "bold" },
	DapUIBreakpointsLine = { fg = C.gutter_fg_grey },
	DapUIWatchesEmpty = { fg = C.white },
	DapUIWatchesValue = { fg = C.white },
	DapUIWatchesError = { fg = C.white },
	DapUIType = { link = "Type" }
}

return dap
