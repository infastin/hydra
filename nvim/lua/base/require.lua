local M = {}
local cache = {}

local function to_fs_path(require_path) return require_path:gsub("%.", "/") end
local function no_ext(path) return path:gsub("%.lua$", "") end

M.tree = function(require_path)
	if cache[require_path] == nil then
		local result = {}
		local fs_path = vim.fn.stdpath("config") .. "/lua/" .. to_fs_path(require_path)

		for entry in Hydra.fs.dir(fs_path) do
			if entry ~= "." and entry ~= ".." then
				local f = fs_path .. "/" .. entry

				local result_entry = {}

				if Hydra.fs.attributes(f, "mode") == "file" then
					entry = no_ext(entry)
					result_entry = require(require_path .. '.' .. entry)
				elseif Hydra.fs.attributes(f, "mode") == "directory" then
					result_entry = M.tree(require_path .. '.' .. entry)
				end

				if type(result_entry) ~= "table" then
					goto continue
				end

				if result[entry] == nil then
					result[entry] = result_entry
				else
					result[entry] = vim.tbl_extend("force", result[entry], result_entry)
				end
			end
			::continue::
		end

		cache[require_path] = result
	end

	return cache[require_path]
end

return M
