local Mouse = {
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

function Mouse:mousemoved(x, y, dx, dy)
	if not SETTINGS.data.debug then
		return
	end
	Mouse.pos.x = x
	Mouse.pos.y = y
	Mouse.delta.x = dx
	Mouse.delta.y = dy
end

function Mouse:mousepressed(x, y, button, _, presses)
	if not SETTINGS.data.debug then
		return
	end
	Mouse.presses.pos.x = x
	Mouse.presses.pos.y = y
	Mouse.presses.button = Mouse.buttonMap[button]
		or (not button and y <= 0 and "scroll down" or "scroll up")
		or "unknown button"
	Mouse.presses.press = presses or 0
	print(button)
end

function Mouse:wheelmoved(dx, dt)
	if not SETTINGS.data.debug then
		return
	end
	Mouse.wheel.dx = dx
	Mouse.wheel.dy = dt
end

function Mouse:draw()
	if not SETTINGS.data.debug then
		return
	end
	love.graphics.print(
		"Mouse Position: x: "
		.. Mouse.pos.x
		.. ", y:"
		.. Mouse.pos.y
		.. ", dx: "
		.. Mouse.delta.x
		.. ", dy: "
		.. Mouse.delta.y
		.. "\nPresse: x:"
		.. Mouse.presses.pos.x
		.. ", y:"
		.. Mouse.presses.pos.y
		.. " button  "
		.. Mouse.presses.button
		.. ", presses: "
		.. Mouse.presses.press
		.. "\nWheel: dx: "
		.. Mouse.wheel.dx
		.. ", dy: "
		.. Mouse.wheel.dy,
		Mouse.pos.x,
		Mouse.pos.y + 30
	)
end

return Mouse
