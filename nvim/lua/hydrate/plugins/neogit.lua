local neogit = {
	NeogitNotificationInfo = { fg = C.info },
	NeogitNotificationWarning = { fg = C.warn },
	NeogitNotificationError = { fg = C.error },

	NeogitDiffAddHighlight = { fg = C.green, bg = C.cursor_grey },
	NeogitDiffDeleteHighlight = { fg = C.red, bg = C.cursor_grey },
	NeogitDiffContextHighlight = { fg = C.white, bg = C.cursor_grey },
	NeogitHunkHeader = { fg = C.white, bg = C.menu_grey, style = "bold" },
	NeogitHunkHeaderHighlight = { fg = C.white, bg = C.menu_grey, style = "bold" }
}

return neogit
