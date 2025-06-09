SETTINGS = {}

local baseSetting = {
	version = "1.0.0",
	debug = true,
}

local function traverseToString(data)
	local result = {}
	for k, v in pairs(data) do
		local value
		if type(v) == "string" then
			value = string.format("%q", v)
		elseif type(v) == "number" or type(v) == "boolean" then
			value = tostring(v)
		elseif type(v) == "table" then
			value = traverseToString(v)
		else
			error("Unsupported value type: " .. type(v))
		end
		table.insert(result, string.format("\t%s = %s,\n", k, value))
	end
	return table.concat(result)
end

local function toString()
	local result = {}

	table.insert(result, "return {\n")
	table.insert(result, traverseToString(SETTINGS.data))
	table.insert(result, "}")
	print("Settings content: " .. table.concat(result))
	return table.concat(result)
end

local function load()
	local file, loadErr = love.filesystem.load("settings.lua")

	if not file then
		print("Could not load settings file: " .. loadErr)
		SETTINGS.data = baseSetting

		-- love.filesystem.newFile("settings.lua")
		local suceess, saveErr = love.filesystem.write("settings.lua", toString())

		if not suceess then
			error("Could not save default settings: " .. saveErr)
		end

		file, loadErr = love.filesystem.load("settings.lua")
		if not file then
			error("Failed to load settings after saving default: " .. loadErr)
		end
	end

	local loadedSettings = file()

	if type(loadedSettings) ~= "table" then
		error("Settings file must return a table.")
	end

	SETTINGS.data = loadedSettings
end

function SETTINGS.get(key)
	if not SETTINGS.data then
		error("Settings not loaded. Call SETTINGS.load() first.")
	end

	local data = SETTINGS.data[key]
	if data == nil then
		error("Setting '" .. key .. "' not found.")
	end

	return data
end

function SETTINGS.set(key, value)
	if not SETTINGS.data then
		error("Settings not loaded. Call SETTINGS.load() first.")
	end

	-- type must be a string or number or boolean or table
	if type(key) ~= "string" then
		error("Key must be a string.")
	end

	if type(value) == nil then
		error("Value must be a string, number, boolean, or table.")
	end

	SETTINGS.data[key] = value

	local success, err = love.filesystem.write("settings.lua", "" .. toString())
	if not success then
		error("Could not save settings: " .. err)
	end
end

load()
