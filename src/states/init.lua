local States = {
    currentState = {},
    StateDebug = require("src.states.state_debug"),
    StateOne = require("src.states.state_one"),
}
States.__index = States

function States:setState(state)
    if type(state) == "string" then
        state = self[state]
    elseif type(state) ~= "table" then
        error("Invalid state name or state object provided.")
    end

    local _, err = self:validateState(state)
    if err then
        return nil, ("Invalid state: " .. err)
    end
    if self:validateState(self.currentState) then
        self.currentState:exit()
    end
    self.currentState = state
    self.currentState:enter()
end

function States:validateState(name)
    if not name or type(name) ~= "table" then
        return false, "State must be a table."
    end
    if not name.enter or type(name.enter) ~= "function" then
        return false, "State must have an 'enter' function."
    end

    if not name.exit or type(name.exit) ~= "function" then
        return false, "State must have an 'exit' function."
    end

    return true, nil
end

function States:update(dt)
    if self.currentState and self.currentState.update then
        self.currentState:update(dt)
    end
end

function States:draw()
    if self.currentState and self.currentState.draw then
        self.currentState:draw()
    end
end

function States:mousemoved(x, y, dx, dy)
    if self.currentState and self.currentState.mousemoved then
        self.currentState:mousemoved(x, y, dx, dy)
    end
end

function States:mousepressed(x, y, button, isTouched, presses)
    if self.currentState and self.currentState.mousepressed then
        self.currentState:mousepressed(x, y, button, isTouched, presses)
    end
end

function States:wheelmoved(dx, dy)
    if self.currentState and self.currentState.wheelmoved then
        self.currentState:wheelmoved(dx, dy)
    end
end

function States:keypressed(key)
    if self.currentState and self.currentState.keypressed then
        self.currentState:keypressed(key)
    end
end

return States
