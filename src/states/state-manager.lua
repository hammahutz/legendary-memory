StateManager = {}

function StateManager:new()
    local obj = {
        currentState = nil,
        states = {}
    }
    setmetatable(obj, self)
    self.__index = self
    return obj
end

function StateManager:addState(name, state)
    self.states[name] = state
    if self.currentState == nil then
        self.currentState = state
    end
end

function StateManager:setState(name)
    if self.states[name] then
        self.currentState.ExitState()
        self.currentState = self.states[name]
        self.currentState.EnterState()
    else
        error("State '" .. name .. "' does not exist.")
    end
end

function StateManager:update(dt)
    if self.currentState and self.currentState.update then
        self.currentState:update(dt)
    end
end

function StateManager:draw()
    if self.currentState and self.currentState.draw then
        self.currentState:draw()
    end
end


function StateManager:mousemoved(x, y, dx, dy)
    if self.currentState and self.currentState.mousemoved then
        self.currentState:mousemoved(x, y, dx, dy)
    end
end

function StateManager:mousepressed(x, y, button, isTouched, presses)
    if self.currentState and self.currentState.mousepressed then
        self.currentState:mousepressed(x, y, button, isTouched, presses)
    end
end

function StateManager:wheelmoved(dx, dy)
    if self.currentState and self.currentState.wheelmoved then
        self.currentState:wheelmoved(dx, dy)
    end
end

function StateManager:keypressed(key)
    if self.currentState and self.currentState.keypressed then
        self.currentState:keypressed(key)
    end
end

return StateManager

