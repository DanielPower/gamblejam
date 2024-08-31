local FileWatcher = function(filePath, callback)
	print(filePath)
	local watcher = {}
	local lastModified = love.filesystem.getInfo(filePath).modtime
	watcher.update = function()
		local fileInfo = love.filesystem.getInfo(filePath)
		if fileInfo then
			local newModified = love.filesystem.getInfo(filePath).modtime
			if lastModified ~= newModified then
				lastModified = newModified
				callback()
			end
		end
	end

	return watcher
end

return FileWatcher
