local syntax = {
	Access = { fg = C.blue },
	Comment = { fg = C.comment_grey, style = "italic" },
	Constant = { fg = C.cyan },
	String = { fg = C.red },
	Character = { fg = C.red },
	Number = { fg = C.orange },
	Boolean = { fg = C.cyan },
	Float = { fg = C.orange },
	Identifier = { fg = C.pink },
	Function = { fg = C.green },
	Statement = { fg = C.periwinkle },
	Conditional = { fg = C.periwinkle },
	Repeat = { fg = C.periwinkle },
	Label = { fg = C.periwinkle },
	Operator = { fg = C.periwinkle },
	Keyword = { fg = C.pink },
	Exception = { fg = C.purple },
	PreProc = { fg = C.blue },
	Include = { fg = C.blue },
	Define = { fg = C.purple },
	Macro = { fg = C.purple },
	PreCondit = { fg = C.blue },
	Type = { fg = C.blue },
	StorageClass = { fg = C.blue },
	Structure = { fg = C.blue },
	Typedef = { fg = C.blue },
	Special = { fg = C.blue },
	SpecialChar = { fg = C.yellow },
	Tag = {},
	Delimiter = { fg = C.periwinkle },
	SpecialComment = { fg = C.comment_grey },
	Debug = {},
	Underlined = { style = "underline" },
	Ignore = {},
	Error = { fg = C.error },
	Todo = { fg = C.purple },
}

return syntax
