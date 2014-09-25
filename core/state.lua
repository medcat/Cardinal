Cardinal.State = class("Cardinal.State"):
  extends(Cardinal.Drawable)
{
  group = nil,

  initialize = function(self)
    self.group = Cardinal.Entity.Group:new()
  end,

  load = function(self)
    print("State Load: " .. self.class.name)
    self.group:load()
  end,

  unload = function(self)
    print("State Unload: " .. self.class.name)
  end,
  -- This is called when the state is entered; this is different
  -- than the load function, because that is called when the
  -- state is created.  Enter is called after load.
  enter = function(self)
    print("State Enter: " .. self.class.name)
  end,
  -- This is called when the state is left; the state may not be
  -- unloaded after the leave.  It is called before unload.
  leave = function(self)
    print("State Leave: " .. self.class.name)
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

Cardinal.State.stack = {}
function Cardinal.State.current()
  return Cardinal.State.stack[#Cardinal.State.stack]
end

function Cardinal.State.push(state)
  local stateInstance, current
  current = Cardinal.State.current()
  if current then
    current:leave()
  end

  stateInstance = state:new()
  stateInstance:load()
  stateInstance:enter()
  print("Pushing state " .. state.name)
  table.insert(Cardinal.State.stack, stateInstance)
  return stateInstance
end

function Cardinal.State.pop()
  local stateInstance = Cardinal.State.current()
  stateInstance:leave()
  stateInstance:unload()
  print("Popping state " .. stateInstance.class.name)
  table.remove(Cardinal.State.stack)
  print("Entering state...")
  Cardinal.State.current():enter()
  print("Done with pop.")
end

function Cardinal.State.replace(state)
  local stateInstance = Cardinal.State.current()
  if stateInstance then
    stateInstance:leave()
    stateInstance:unload()
    print("Replacing " .. stateInstance.class.name .. " with " .. state.name)
  else
    print("Pushing state " .. state.name)
  end
  table.remove(Cardinal.State.stack)
  stateInstance = state:new()
  stateInstance:load()
  stateInstance:enter()
  table.insert(Cardinal.State.stack, stateInstance)
  return stateInstance

end
