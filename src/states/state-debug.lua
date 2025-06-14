local StateDebug = {}
StateDebug.__index = StateDebug

function StateDebug:new()
    local self = setmetatable({}, self)
    return self
end

local Mouse = require "debug.mouse"

function StateDebug:mousemoved(x, y, dx, dy)
    Mouse:mousemoved(x, y, dx, dy)
end

function StateDebug:mousepressed(x, y, button, isTouched, presses)
    Mouse:mousepressed(x, y, button, isTouched, presses)
end

function StateDebug:keypressed(key)
    if key == "escape" then
        love.event.quit()
    elseif key == "f1" then
        SETTINGS.set("debug", not SETTINGS.data.debug)
    end
end

function StateDebug:wheelmoved(dx, dy)
    Mouse:wheelmoved(dx, dy)

end

function StateDebug:update(dt)
end

function StateDebug:draw()
    Mouse:draw()
end

return StateDebug
