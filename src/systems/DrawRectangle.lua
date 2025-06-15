local DrawRectangle = {}
DrawRectangle.__index = DrawRectangle

function DrawRectangle:draw()
    local entiteis = Entities:getEntitiesByComponent("Rectangle")
    for _, entity in ipairs(entiteis) do
    print("DrawRectangle")
        local rectangle = entity:getComponent("Rectangle")
        if rectangle then
            love.graphics.setColor(rectangle.data.color)
            love.graphics.rectangle("fill", rectangle.data.x, rectangle.data.y, rectangle.data.width, rectangle.data.height)
        end
    end
end



return setmetatable(DrawRectangle, DrawRectangle)