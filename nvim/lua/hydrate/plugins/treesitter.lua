local treesitter = {
	TSNone = { group = "@none", fg = C.white },
	TSParameter = { group = "@parameter", fg = C.white },
	TSNamespace = { group = "@namespace", fg = C.pink },
	TSConstant = { group = "@constant", link = "Constant" },
	TSConstBuiltin = { group = "@constant.builtin", link = "Constant" },
	TSConstMacro = { group = "@constant.macro", link = "Constant" },
	TSKeywordReturn = { group = "@keyword.return", link = "Statement" },
	TSFuncBuiltin = { group = "@function.builtin", link = "Function" },
	TSAccess = { group = "@access", link = "Access" },
	TSStatement = { group = "@statement", link = "Statement" },
	TSType = { group = "@type", link = "Type" },
	TSTypedef = { group = "@typedef", link = "Typedef" },
	TSStorageClass = { group = "@storageClass", link = "StorageClass" },
	TSDefine = { group = "@define", link = "Define" },
	TSPreCondit = { group = "@preCondit", link = "PreCondit" },
	TSVariable = { group = "@variable", fg = C.white }
}

treesitter = Hydra.utils.tbl_extend_path("keep", treesitter, "hydrate.plugins.treesitter")

return treesitter
