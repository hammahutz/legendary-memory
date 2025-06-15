local Rectangle = {
}
Rectangle.__index = Rectangle

function Rectangle:__call()
    local instances = {
        name = debug.getinfo(1, "S").source:match("([^/\\]+)%.lua$"),
        data = {
            x = 200,
            y = 200,
            width = 100,
            height = 100,
            color = { 1, 1, 1, 1 } -- Default color white with full opacity
        }
    }
    return setmetatable(instances, Rectangle)
end

return setmetatable(Rectangle, Rectangle)
