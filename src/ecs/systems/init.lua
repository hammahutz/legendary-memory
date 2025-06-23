local Systems = {
	drawable = {},
	updatable = {},
	DrawRectangle = require("src.ecs.systems.draw_rectangle"),
}
Systems.__index = Systems

function Systems:addToUpdate(system)
	if not system or type(system) ~= "table" then
		return nil, "System must be a table"
	end
	if not system.draw or type(system.update) ~= "function" then
		return nil, "System must have a 'update' function"
	end

	table.insert(self.updatable, system)
	return system, nil
end

function Systems:addToDraw(system)
	if not system or type(system) ~= "table" then
		return nil, "System must be a table"
	end
	if not system.draw or type(system.draw) ~= "function" then
		return nil, "System must have a 'draw' function"
	end

	table.insert(self.drawable, system)
	return system, nil
end

function Systems:update(dt)
	for _, system in ipairs(self.updatable) do
		system:update(dt)
	end
end

function Systems:draw()
	for _, system in ipairs(self.drawable) do
		system:draw()
	end
end

Systems.__index = Systems
return setmetatable(Systems, Systems)
