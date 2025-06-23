local mouse_debug = require "src.utils.mouse_debug"
local settings = require "src.utils.settings"

local StateDebug = {
    name = debug.getinfo(1, "S").source:match("([^/\\]+)%.lua$")
}
StateDebug.__index = StateDebug

function StateDebug:enter()
    local Components = require("src.ecs.components")
    local Entities = require("src.ecs.entities")
    local Systems = require("src.ecs.systems")


    local rectOne = Components.Rectangle()
    local rectTwo = Components.Rectangle()

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
    Systems:addToDraw(Systems.DrawRectangle)

end

function StateDebug:exit()

end

function StateDebug:mousemoved(x, y, dx, dy)

    mouse_debug:mousemoved(x, y, dx, dy)
end

function StateDebug:mousepressed(x, y, button, isTouched, presses)

    mouse_debug:mousepressed(x, y, button, isTouched, presses)
end

function StateDebug:keypressed(key)
    if key == "escape" then
        love.event.quit()
    elseif key == "f1" then
        print(settings.data.debug)
        settings:set("debug", not settings.data.debug)
        print("Debug mode is now: " .. tostring(settings.data.debug))
    end
end

function StateDebug:wheelmoved(dx, dy)

    mouse_debug:wheelmoved(dx, dy)

end

function StateDebug:update(dt)
end

function StateDebug:draw()

    mouse_debug:draw()
end

return StateDebug
