local Entity = require("src.ecs.entities.entity")

local Entities = {
	entities = {},
	idCounter = 1,
}

function Entities:addEntity(...)
	local entity, err = Entity(...)
	if not entity then
		return nil, "Failed to create entity." .. err
	end

	entity.id = self.idCounter
	self.idCounter = self.idCounter + 1
	self.entities[entity.id] = entity

	if self.entities[entity.id] == nil then
		return nil, "Failed to add entity with id " .. tostring(entity.id)
	end
	return entity, nil
end

function Entities:removeEntity(id)
	if not self.entities[id] then
		return nil, "Entity with id " .. tostring(id) .. " does not exist."
	end

	self.entities[id].components = nil
	self.entities[id].id = nil
	self.entities[id] = nil

	return id, nil
end

function Entities:getEntityById(id)
	if not self.entities[id] then
		return nil, "Entity with id " .. tostring(id) .. " does not exist."
	end

	return self.entities[id], nil
end

function Entities:getEntitiesByComponent(componentType)
	local result = {}
	for _, entity in ipairs(self.entities) do
		print(entity.components.Rectangle, componentType)
		for name, _ in pairs(entity.components) do
			if name == componentType then
				table.insert(result, entity)
				break
			end
		end
	end
	if #result == 0 then
		return nil, "No entities found with component type '" .. componentType .. "'."
	end
	return result, nil
end

return setmetatable(Entities, Entities)
