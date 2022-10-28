local M = require("lfs")

M.exists = function(path)
	if type(path) ~= "string" then return false end
	return os.rename(path, path) and true or false
end

M.is_dir = function(path)
	if type(path) ~= "string" then return false end
	if M.exists(path) then
		if M.attributes(path, "mode") == "directory" then
			return true
		else
			return false
		end
	else
		return false
	end
end

M.is_file = function(path)
	if type(path) ~= "string" then return false end
	if M.exists(path) then
		if M.attributes(path, "mode") == "file" then
			return true
		else
			return false
		end
	else
		return false
	end
end

return M
