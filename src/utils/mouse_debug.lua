local Settings = require("src.utils.settings")

local mouse = {
	pos = { x = 0, y = 0 },
	delta = { x = 0, y = 0 },
	presses = {
		pos = { x = 0, y = 0 },
		button = 0,
		press = 0,
	},
	wheel = { dx = 0, dy = 0 },
	buttonMap = {
		[1] = "left click",
		[2] = "right click",
		[3] = "middle click",
		[4] = "backward",
		[5] = "forward",
		[6] = "scroll up",
		[7] = "scroll down",
	}
}

mouse.__index = mouse


function mouse:mousemoved(x, y, dx, dy)
	print(Settings.data.debug)
	if not Settings.data.debug then
	end
	mouse.pos.x = x
	mouse.pos.y = y
	mouse.delta.x = dx
	mouse.delta.y = dy
end

function mouse:mousepressed(x, y, button, _, presses)
	if not Settings.data.debug then
		return
	end
	mouse.presses.pos.x = x
	mouse.presses.pos.y = y
	mouse.presses.button = mouse.buttonMap[button]
		or (not button and y <= 0 and "scroll down" or "scroll up")
		or "unknown button"
	mouse.presses.press = presses or 0
	print(button)
end

function mouse:wheelmoved(dx, dt)
	if not Settings.data.debug then
		return
	end
	mouse.wheel.dx = dx
	mouse.wheel.dy = dt
end

function mouse:draw()
	if not Settings.data.debug then
		return
	end
	love.graphics.print(
		"Mouse Position: x: "
		.. mouse.pos.x
		.. ", y:"
		.. mouse.pos.y
		.. ", dx: "
		.. mouse.delta.x
		.. ", dy: "
		.. mouse.delta.y
		.. "\nPresse: x:"
		.. mouse.presses.pos.x
		.. ", y:"
		.. mouse.presses.pos.y
		.. " button  "
		.. mouse.presses.button
		.. ", presses: "
		.. mouse.presses.press
		.. "\nWheel: dx: "
		.. mouse.wheel.dx
		.. ", dy: "
		.. mouse.wheel.dy,
		mouse.pos.x,
		mouse.pos.y + 30
	)
end

return mouse
