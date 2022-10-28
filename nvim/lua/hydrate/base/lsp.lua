local lsp = {
	LspDiagnosticsSignError = { fg = C.error, style = "bold" },
	LspDiagnosticsSignWarn = { fg = C.warn, style = "bold" },
	LspDiagnosticsSignInfo = { fg = C.info, style = "bold" },
	LspDiagnosticsSignHint = { fg = C.hint, style = "bold" },
	DiagnosticError = { fg = C.error, style = "bold" },
	DiagnosticWarn = { fg = C.warn, style = "bold" },
	DiagnosticInfo = { fg = C.info, style = "bold" },
	DiagnosticHint = { fg = C.hint, style = "bold" },
	LspReferenceRead = { bg = C.visual_grey },
	LspReferenceText = { bg = C.visual_grey },
	LspReferenceWrite = { bg = C.visual_grey }
}

return lsp
