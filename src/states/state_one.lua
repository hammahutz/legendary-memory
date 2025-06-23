local State = {}
State.__index = State


function State:draw()
    love.graphics.print("State: One", 10, 10)
end

return setmetatable(State, Stat)
