-- Skapa en metatable
local State = {}
function State:new()
    self = setmetatable({}, State)
    State.__index = State
    return self
end


function State:draw()
    love.graphics.print("State: One", 10, 10)
end

return State
