local Velocity = {}

function Velocity:__call(dx, dy)
	local instance = setmetatable({
		name = debug.getinfo(1, "S").source:match("([^/\\]+)%.lua$"),
		data = {
			dx = dx or 100,
			dy = dy or 100,
		},
	}, Velocity)

	return instance
end

return setmetatable(Velocity, Velocity)
