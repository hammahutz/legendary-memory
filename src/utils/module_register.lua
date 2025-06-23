local ModuleRegister = {}
ModuleRegister.__index = ModuleRegister

local register = {}

-- function ModuleRegister:loadModulesFrom(directory)
--     -- local directory = directory:match("^@(.+)/[^/]+$")
--     local files = love.filesystem.getDirectoryItems(directory)

--     for _, file in ipairs(files) do
--         if file ~= 'init.lua' and file ~= "module-register.lua" then
--             local moduleName = file:match("(.+)%.lua$")
--             local fullPath = directory .. "/" .. moduleName
--             print("Loading module: " .. fullPath)
--             register[moduleName] = require(fullPath)
--         end
--     end
-- end

local function isDirectory(path)
    local info = love.filesystem.getInfo(path)
    return info and info.type == "directory"
end

-- Huvudfunktion som rekursivt söker efter init.lua i alla mappar
function ModuleRegister:requireAll(basePath)
    basePath = basePath or ""

    for _, item in ipairs(love.filesystem.getDirectoryItems(basePath)) do
        local fullPath = (basePath == "" and item) or (basePath .. "/" .. item)
        local directory = item:match("(.+)$")

        if isDirectory(fullPath) then
            local directory = item:match("(.+)$")
            register[directory] = require(fullPath)
            ModuleRegister.requireAll(fullPath)
        elseif item ~= "init.lua" and item ~= "module_register.lua"  and item ~= "main.lua" then
            -- local directory = directory:match("^@(.+)/[^/]+$")
            local fileDir = fullPath:match("(.+)%.lua$")
            local fileName = item:match("(.+)%.lua$")
            print("Loading module: " .. fileDir)
                register[fileName] = require(fileDir)
        end
    end
end

ModuleRegister:requireAll("utils")

return setmetatable(ModuleRegister, ModuleRegister)
