bishop.state = class("bishop.state"):
  extends(bishop.drawable)
{
  group = nil,

  initialize = function(self)
    self.group = bishop.entity.group:new()
  end,

  load = function(self)
    bishop.console:log("[state] load " .. self.class.name)
    self.group:load()
  end,

  unload = function(self)
    bishop.console:log("[state] unload " .. self.class.name)
  end,
  -- This is called when the state is entered; this is different
  -- than the load function, because that is called when the
  -- state is created.  Enter is called after load.
  enter = function(self)
    bishop.console:log("[state] enter " .. self.class.name)
  end,
  -- This is called when the state is left; the state may not be
  -- unloaded after the leave.  It is called before unload.
  leave = function(self)
    bishop.console:log("[state] leave " .. self.class.name)
  end,

  draw = function(self)
    self.group:draw()
  end,

  update = function(self, dt)
    self.group:update(dt)
  end,

  input = function(self) end,
  press = function(self) end,
  release = function(self) end,
}

bishop.state.stack = {}
function bishop.state.current()
  return bishop.state.stack[#bishop.state.stack]
end

function bishop.state.push(state)
  local stateInstance, current
  current = bishop.state.current()
  if current then
    current:leave()
  end

  stateInstance = state:new()
  stateInstance:load()
  stateInstance:enter()
  bishop.console:log("[state/manager.push] pushing " .. state.name)
  table.insert(bishop.state.stack, stateInstance)
  return stateInstance
end

function bishop.state.pop()
  local stateInstance = bishop.state.current()
  stateInstance:leave()
  stateInstance:unload()
  bishop.console:log("[state/manager.pop] popping " .. stateInstance.class.name)
  table.remove(bishop.state.stack)
  bishop.console:log("[state/manager.pop] entering previous")
  bishop.state.current():enter()
  bishop.console:log("[state/manager.pop] pop over")
end

function bishop.state.replace(state)
  local stateInstance = bishop.state.current()
  if stateInstance then
    stateInstance:leave()
    stateInstance:unload()
    bishop.console:log("[state/manager.replace] " .. stateInstance.class.name .. " -> " .. state.name)
  else
    bishop.console:log("[state/manager.replace] pushing " .. state.name)
  end
  table.remove(bishop.state.stack)
  stateInstance = state:new()
  stateInstance:load()
  stateInstance:enter()
  table.insert(bishop.state.stack, stateInstance)
  return stateInstance

end
