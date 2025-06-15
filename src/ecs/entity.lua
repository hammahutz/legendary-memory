local Entity = {}

Entity.__index = Entity

function Entity:new()
	local instance = setmetatable({
		components = {},
	}, Entity)

	return instance
end

function Entity:addComponent(...)
	if not self.components then
		self.components = {}
	end

	for _, component in ipairs({ ... }) do
		if type(component) ~= "table" then
			error("Component must be a table")
		end
		if not component.type then
			error("Component must have a 'type' field")
		end
		table.insert(self.components, component)
	end
end

function Entity:getComponent(componentType)
	if not self.components then
		return nil
	end
	for _, component in ipairs(self.components) do
		if component.type == componentType then
			return component
		end
	end
	return nil
end

function Entity.__call(...)
	return Entity:new(...)
end

return Entity
