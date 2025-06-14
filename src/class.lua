
local Mouse = {}
Mouse.__index = Mouse

function Mouse:new(...)
		self.pos = { x = 0, y = 0 }
		self.delta = { x = 0, y = 0 }
		self.presses = {
			pos = { x = 0, y = 0 },
			button = 0,
			press = 0,
		}
		self.wheel = { dx = 0, dy = 0 }
end

function Mouse:__call(...)
	self = setmetatable({}, self)
	self:new(...)
	return self
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
	if not SETTINGS.data.debug then
		return
	end
	self.pos.x = x
	self.pos.y = y
	self.delta.x = dx
	self.delta.y = dy
end

function Mouse:mousepressed(x, y, button, _, presses)
	if not SETTINGS.data.debug then
		return
	end
	self.presses.pos.x = x
	self.presses.pos.y = y
	self.presses.button = buttonMap[button]
		or (not button and y <= 0 and "scroll down" or "scroll up")
		or "unknown button"
	self.presses.press = presses or 0
	print(button)
end

function Mouse:wheelmoved(dx, dt)
	if not SETTINGS.data.debug then
		return
	end
	self.wheel.dx = dx
	self.wheel.dy = dt
end

function Mouse:draw()
	if not SETTINGS.data.debug then
		return
	end
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