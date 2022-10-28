-- Declare "API"
Hydra = {
	plugins = {},
	require = {},
	fs = {},
	loaded_plugins = {},
}

local function load_plugins()
	local plugins = require("plugins")
	local rocks = require("rocks")
	local plugin_loader = require("base.plugin-loader")

	plugin_loader.init()
	plugin_loader.load(plugins, rocks)

	return plugin_loader
end

local function install()
	load_plugins()
end

local function main()
	local loader = load_plugins()

	-- Set "API"
	Hydra.fs = require("base.fs_utils")
	Hydra.require = require("base.require")
	Hydra.plugins = Hydra.require.tree("plugins")

	local utility = Hydra.require.tree("base.utility")
	Hydra = vim.tbl_extend("keep", Hydra, utility)

	for _, plugin in pairs(require("plugins")) do
		local plugin_name = string.match(plugin[1], ".*/(.*)")

		local subname, _ = string.gsub(plugin_name, "[%.%-]", "_")
		subname, _ = string.gsub(subname, "_n?vim", "")
		subname, _ = string.gsub(subname, "n?vim_", "")

		Hydra.loaded_plugins[subname] = true
	end

	-- Init settings
	require("settings")

	-- Init keymaps
	require("keymaps")

	-- Init augroups
	require("augroups")

	-- Pre-Init plugins
	loader.pre()

	for name, conf in pairs(Hydra.plugins) do
		if not Hydra.loaded_plugins[name] then
			goto continue
		end

		if conf.pre ~= nil and type(conf.pre) == "function" then
			conf.pre()
		end

		::continue::
	end

	-- Init plugins
	for name, conf in pairs(Hydra.plugins) do
		if not Hydra.loaded_plugins[name] then
			goto continue
		end

		if conf.init ~= nil and type(conf.init) == "function" then
			conf.init()
		end

		::continue::
	end

	-- Post-Init plugins
	for name, conf in pairs(Hydra.plugins) do
		if not Hydra.loaded_plugins[name] then
			goto continue
		end

		if conf.post ~= nil and type(conf.post) == "function" then
			conf.post()
		end

		::continue::
	end
end

return {
	run = main,
	install = install,
}
