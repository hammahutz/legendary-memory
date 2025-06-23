local Entity = {}
Entity.__index = Entity

function Entity:addComponent(...)
	for _, rawComponent in pairs({ ... }) do
		local component, err = self:validateComponent(rawComponent)
		if component then
			self.components[component.name] = component.data
		else
			return nil, "Failed to create component: " .. tostring(err)
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

function Entity:validateComponent(component)
	if type(component) ~= "table" then
		return nil, "Component must be a table., is " .. type(component)
	end

	if not component.name or type(component.name) ~= "string" then
		return nil, "Component must have a 'name' field of type string."
	end

	if not component.data or type(component.data) ~= "table" then
		return nil, "Component must have a 'data' field of type table."
	end

	return component, nil
end

function Entity:__call(...)
	local instance = setmetatable({ components = {} }, Entity)
	local _, err = instance:addComponent(...)
	if err then
		return nil, "Error adding component to entity: " .. err
	end
	return instance, nil
end

return setmetatable(Entity, Entity)
