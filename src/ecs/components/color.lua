local Color = {}

function Color:__call(color)
	local instance = setmetatable({
		name = debug.getinfo(1, "S").source:match("([^/\\]+)%.lua$"),
		data = {
			color = color or { 1, 1, 1, 1 },
		},
	}, Color)

	return instance
end

return setmetatable(Color, Color)
