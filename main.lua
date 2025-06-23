require("conf")

-- require("src.debug")
-- local ModuleRegister = require("src.utils.module_register")

local States = require("src.states")
local Systems = require("src.ecs.systems")

function love.load()
    print("Loading Mouse Position Example...")
    love.window.setTitle("Mouse Position Example")
    love.window.setMode(800, 600)



    States:setState(States.StateDebug)
end

function love.mousemoved(x, y, dx, dy)
    States:mousemoved(x, y, dx, dy)
end

function love.mousepressed(x, y, button, isTouched, presses)
    States:mousepressed(x, y, button, isTouched, presses)
end

function love.keypressed(key)
    States:keypressed(key)
end

function love.wheelmoved(dx, dy)
    States:wheelmoved(dx, dy)
end

function love.update(dt)
    States:update(dt)
    Systems:update(dt)
end

function love.draw()
    States:draw()
    Systems:draw()
end
