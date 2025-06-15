local Entity = require("ecs.entity")
local Entities = {
	entities = {},
	idCounter = 1,
}

function Entities:addEntity(entity)
	-- entity = Entity(entity)

	entity.id = self.idCounter

	self.idCounter = self.idCounter + 1
	self.entities[entity.id] = entity

	if self.entities[entity.id] == nil then
		return nil, "Failed to add entity with id " .. tostring(entity.id)
	end
	return entity.id, nil
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
		for name, component in pairs(entity.components) do
			print("Checking component type: " .. tostring(component.name))
			if component.type == componentType then
				print("Found component of type: " .. tostring(componentType) .. " in entity with id: " .. tostring(entity.id))
				table.insert(result, entity)
				break
			end
		end
	end
	return result
end

return Entities
