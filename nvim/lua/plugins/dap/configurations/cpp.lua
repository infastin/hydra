local cpp = {
	{
		name = "Launch",
		type = "lldb",
		request = "launch",
		program = "${workspaceFolder}/build/${relativeFileDirname}/${fileBasenameNoExtension}",
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		args = {},
		runInTerminal = false
	}
}

return cpp
