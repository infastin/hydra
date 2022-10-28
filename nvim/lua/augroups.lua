Hydra.utils.augroup("c_group", {
	{ "BufEnter", "*.h", "setf c" },
	{ "BufEnter", "*.hpp", "setf cpp" }
})

Hydra.utils.autocmd({ "BufNewFile", "*.*", "lua Hydra.fn.load_template()" })
