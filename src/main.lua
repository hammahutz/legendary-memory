require("require")
StateManager = require("states.state-manager")
StateDebug = require("states.state-debug")
StateOne = require("states.state-one")

local states = StateManager:new()
local debugState = StateDebug:new()

function love.load()
	love.window.setTitle("Mouse Position Example")
	love.window.setMode(800, 600)

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
end

function love.draw()
	states:draw()
	debugState:draw()
end
