local Entity = {}
Entity.__index = Entity
setmetatable(Entity, Entity)

function Entity:addComponent(...)
	local componentsToAdd = {}

	for _, component in pairs({ ... }) do
		if type(component) ~= "table" then
			return nil, "Component must be a table"
		end
		if not component.name then
			return nil, "Component must have a 'name' field"
		end
		if not component.data then
			return nil, "Component must have a 'data' field"
		end

		table.insert(componentsToAdd, component)
	end

	for _, value in ipairs(componentsToAdd) do
		self.components[value.name] = value.data

		print("Adding component: " .. value.name .. " with data:")
		for k, v in pairs(value.data) do
			print("  " .. tostring(k) .. ": " .. tostring(v))
		end
	end

	return self, nil
end

function Entity:getComponent(componentType)
	if not self.components then
		return nil, "Entity has no components table."
	end
	for name, component in pairs(self.components) do
		if name == componentType then
			return component, nil
		end
	end
	return nil, "Component of type '" .. componentType .. "' not found in entity."
end

function Entity:__call(...)
	local instance = setmetatable({ components = {} }, Entity)
	instance:addComponent(...)
	return instance
end

return setmetatable(Entity, Entity)
