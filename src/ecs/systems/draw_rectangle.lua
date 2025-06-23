local draw_rectangle = {}
draw_rectangle.__index = draw_rectangle
local Entities = require("src.ecs.entities")

function draw_rectangle:draw()
    local entities, err = Entities:getEntitiesByComponent("Rectangle")
    if err or not entities then

			print(err)
        return
    end

    for _, entity in ipairs(entities) do
        local rectangle, err = entity:getComponent("Rectangle")
        if rectangle then
            love.graphics.setColor(rectangle.color)
            love.graphics.rectangle("fill", rectangle.x, rectangle.y, rectangle.width, rectangle.height)
        else
            print("Error getting Rectangle component: " .. err)
        end

    end
end

return setmetatable(draw_rectangle, draw_rectangle)

