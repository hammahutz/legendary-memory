local Components = {
    Color = require("src.ecs.components.color"),
    Rectangle = require("src.ecs.components.rectangle"),
    Position = require("src.ecs.components.position"),
    Velocity = require("src.ecs.components.velocity"),
}
Components.__index = Components

local function validateComponent()
    for name, component in pairs(Components) do

        if type(component) ~= "table" then
            return nil, "Component must be a table., is " .. type(component)
        end

        if not component.name or type(component.name) ~= "string" then
            return nil, "Component must have a 'name' field of type string."
        end

        if not component.data or type(component.data) ~= "table" then
            return nil, "Component must have a 'data' field of type table."
        end
    end

    return true, nil
end

return Components
