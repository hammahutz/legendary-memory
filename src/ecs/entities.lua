local Entities = {}
Entities.__index = Entities

function Entities:new()
	local instance = setmetatable({
		entities = {},
		idCounter = 0,
	}, Entities)
	return instance
end

function Entities:addEntity(entity)
	entity = entity or {}
	entity.components = entity.components or {}

	entity.id = self.idCounter + 1

	table.insert(self.entities, entity)
	return entity
end

function Entities:getEntityById(id)
	for _, entity in ipairs(self.entities) do
		if entity.id == id then
			return entity
		end
	end
	return nil
end

function Entities:getEntitiesByComponent(componentType)
	local result = {}
	for _, entity in ipairs(self.entities) do
		for _, component in ipairs(entity.components) do
			if component.type == componentType then
				table.insert(result, entity)
				break
			end
		end
	end
	return result
end

return Entities
