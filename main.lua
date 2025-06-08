require("love")
require("settings")
local Mouse = require("debug.mouse")

local objects = {}

function love.load()
	love.window.setTitle("Mouse Position Example")
	love.window.setMode(800, 600)

	table.insert(objects, Mouse:new())
end

function love.mousemoved(x, y, dx, dy)
	for _, obj in ipairs(objects) do
		if obj.mousemoved then
			obj:mousemoved(x, y, dx, dy)
		end
	end
end

function love.mousepressed(x, y, button, istouch, presses)
	for _, obj in ipairs(objects) do
		if obj.mousepressed then
			obj:mousepressed(x, y, button, istouch, presses)
		end
	end
end

function love.keypressed(key)
	if key == "escape" then
		love.event.quit()
	elseif key == "f1" then
		SETTINGS.debug = not SETTINGS.debug
	end
end

function love.wheelmoved(dx, dy)
	for _, obj in ipairs(objects) do
		if obj.wheelmoved then
			obj:mousepressed(dx, dy)
		end
	end
end

function love.draw()
	for _, obj in ipairs(objects) do
		if obj.draw then
			obj:draw()
		end
	end
end
