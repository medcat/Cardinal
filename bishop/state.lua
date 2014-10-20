define "bishop.state": extends "bishop.drawable":
as(function(class, instance)

  instance.group = nil

  function instance:initialize()
    self.group = bishop.entity.group:new()
  end

  function instance:load()
    bishop.console:log("[state] load " .. self.class.name)
    self.group:load()
  end

  function instance:unload()
    bishop.console:log("[state] unload " .. self.class.name)
  end

  -- This is called when the state is entered; this is different
  -- than the load function, because that is called when the
  -- state is created.  Enter is called after load.
  function instance:enter()
    bishop.console:log("[state] enter " .. self.class.name)
  end

  -- This is called when the state is left; the state may not be
  -- unloaded after the leave.  It is called before unload.
  function instance:leave()
    bishop.console:log("[state] leave " .. self.class.name)
  end

  function instance:draw()
    self.group:draw()
  end

  function instance:update(dt)
    self.group:update(dt)
  end

  function instance:input() end
  function instance:press() end
  function instance:release() end

  class.stack = {}
  function class.current()
    return class.stack[#class.stack]
  end

  function class.push(pushed)
    local stateInstance, current
    current = class.current()
    if current then
      current:leave()
    end

    stateInstance = pushed:new()
    stateInstance:load()
    stateInstance:enter()
    bishop.console:log("[state/manager.push] pushing " .. pushed.name)
    table.insert(class.stack, stateInstance)
    return stateInstance
  end

  function class.pop()
    local stateInstance = class.current()
    stateInstance:leave()
    stateInstance:unload()
    bishop.console:log("[state/manager.pop] popping " .. stateInstance.class.name)
    table.remove(class.stack)
    bishop.console:log("[state/manager.pop] entering previous")
    class.current():enter()
    bishop.console:log("[state/manager.pop] pop over")
  end

  function class.replace(state)
    local stateInstance = class.current()
    if stateInstance then
      stateInstance:leave()
      stateInstance:unload()
      bishop.console:log("[state/manager.replace] " .. stateInstance.class.name .. " -> " .. state.name)
    else
      bishop.console:log("[state/manager.replace] pushing " .. state.name)
    end
    table.remove(class.stack)
    stateInstance = state:new()
    stateInstance:load()
    stateInstance:enter()
    table.insert(class.stack, stateInstance)
    return stateInstance

  end
end)
