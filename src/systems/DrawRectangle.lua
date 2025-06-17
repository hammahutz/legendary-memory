local DrawRectangle = {}
DrawRectangle.__index = DrawRectangle

function DrawRectangle:draw()
    local entities = Entities:getEntitiesByComponent("Rectangle")
    for _, entity in ipairs(entities) do
        local rectangle = entity:getComponent("Rectangle")
        if rectangle ~= nil then
            love.graphics.setColor(rectangle.color)
            love.graphics.rectangle("fill", rectangle.x, rectangle.y, rectangle.width, rectangle.height)
        end
    end
end



return setmetatable(DrawRectangle, DrawRectangle)