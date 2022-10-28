local doxygen = {
	doxygenCommentWhite = { fg = C.white },
	doxygenParam = { fg = C.cyan },
	doxygenSpecialOnelineDesc = { link = "Comment" },
	doxygenSpecialTypeOnelineDesc = { link = "Comment" },
	doxygenBrief = { link = "Comment" },
}

vim.api.nvim_command("syn match doxygenParamName '[A-za-z0-9._:]\\+' contained nextgroup=doxygenSpecialMultilineDesc skipwhite")

return doxygen
