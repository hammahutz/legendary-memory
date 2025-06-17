local Rectangle = {}
Rectangle.__index = Rectangle

function Rectangle:__call(x, y, width, height, color)
	local instance = setmetatable({
		name = debug.getinfo(1, "S").source:match("([^/\\]+)%.lua$"),
		data = {
			x = x or 0,
			y = y or 0,
			width = width or 100,
			height = height or 100,
			color = color or { 1, 1, 1, 1 },
		},
	}, Rectangle)

	return instance
end

return setmetatable(Rectangle, Rectangle)
