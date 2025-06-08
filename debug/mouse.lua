local Mouse = {}
function Mouse:new()
	local obj = {
		pos = { x = 0, y = 0 },
		delta = { x = 0, y = 0 },
		presses = {
			pos = { x = 0, y = 0 },
			button = 0,
			press = 0,
		},
		wheel = { dx = 0, dy = 0 },
	}

	setmetatable(obj, self)
	self.__index = self
	return obj
end

local buttonMap = {
	[1] = "left click",
	[2] = "right click",
	[3] = "middle click",
	[4] = "backward",
	[5] = "forward",
	[6] = "scroll up",
	[7] = "scroll down",
}

function Mouse:mousemoved(x, y, dx, dy)
	self.pos.x = x
	self.pos.y = y
	self.delta.x = dx
	self.delta.y = dy
end

function Mouse:mousepressed(x, y, button, _, presses)
	self.presses.pos.x = x
	self.presses.pos.y = y
	self.presses.button = buttonMap[button]
		or (not button and y <= 0 and "scroll down" or "scroll up")
		or "unknown button"
	self.presses.press = presses or 0
	print(button)
end

function Mouse:wheelmoved(dx, dt)
	self.wheel.dx = dx
	self.wheel.dy = dt
end

function Mouse:draw()
	love.graphics.print(
		"Mouse Position: x: "
			.. self.pos.x
			.. ", y:"
			.. self.pos.y
			.. ", dx: "
			.. self.delta.x
			.. ", dy: "
			.. self.delta.y
			.. "\nPresse: x:"
			.. self.presses.pos.x
			.. ", y:"
			.. self.presses.pos.y
			.. " button  "
			.. self.presses.button
			.. ", presses: "
			.. self.presses.press
			.. "\nWheel: dx: "
			.. self.wheel.dx
			.. ", dy: "
			.. self.wheel.dy,
		self.pos.x,
		self.pos.y + 30
	)
end

return Mouse
