require("require")

Entities = require("src.ecs.entities.init")
Components = require("ecs.components")
Systems = require("src.ecs.systems.init")
Rectangle = require("components.Rectangle")
DrawRectangle = require("src.ecs.systems.DrawRectangle")

StateManager = require("states.state-manager")
StateDebug = require("states.state-debug")
StateOne = require("states.state-one")

local states = StateManager:new()
local debugState = StateDebug:new()

function love.load()
	print("Loading Mouse Position Example...")
	love.window.setTitle("Mouse Position Example")
	love.window.setMode(800, 600)

	local rectOne = Rectangle()
	local rectTwo = Rectangle()

	print("Rectangle One: ", rectOne.name)
	print("Rectangle Two: ", rectTwo.data.x)

	local one, errOne = Entities:addEntity(rectOne)
	local two, errTwo = Entities:addEntity(rectTwo)
	if errOne then
		print("Error adding entity one: " .. errOne)
	end
	if errTwo then
		print("Error adding entity two: " .. errTwo)
	end
	Systems:addToDraw(DrawRectangle)

	states:addState("one", StateOne:new())
	states:addState("two", StateOne:new())
end

function love.mousemoved(x, y, dx, dy)
	states:mousemoved(x, y, dx, dy)
	debugState:mousemoved(x, y, dx, dy)
end

function love.mousepressed(x, y, button, isTouched, presses)
	states:mousepressed(x, y, button, isTouched, presses)
	debugState:mousepressed(x, y, button, isTouched, presses)
end

function love.keypressed(key)
	states:keypressed(key)
	debugState:keypressed(key)
end

function love.wheelmoved(dx, dy)
	states:wheelmoved(dx, dy)
	debugState:wheelmoved(dx, dy)
end

function love.update(dt)
	states:update(dt)
	Systems:update(dt)
end

function love.draw()
	states:draw()
	debugState:draw()
	Systems:draw()
end
