local Position = {}

function Position:__call(x, y)
	local instance = setmetatable({
		name = debug.getinfo(1, "S").source:match("([^/\\]+)%.lua$"),
		data = {
			x = x or 100,
			y = y or 100,
		},
	}, Position)

	return instance
end

return setmetatable(Position, Position)
