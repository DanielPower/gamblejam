local inspect = require("lib.inspect")

local function pprint(...)
	print(inspect(...))
end

return pprint
