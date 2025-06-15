local Components = {}
Components.__index = Components


function Components:create(name, data)
    if type(name) ~= "string" then
        return nil, "Component name must be a string"
    end
    if type(data) ~= "table" and data ~= {} then
        return nil, ("Component data must be a table")
    end
    if self[name] then
        return nil, ("Component '" .. name .. "' already exists")
    end

    Components[name] = data

    return Components[name], nil
end

return Components
