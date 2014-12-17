define "bishop.state.stack":
as(function(class, instance)

  instance.stack = nil

  function instance:initialize()
    self.stack = {}
  end

  function instance:current()
    return self.stack[#self.stack]
  end

  function instance:nth(n)
    if n > (#self.stack + 1) then
      error("Argument n is greater than stack size!")
    end

    return self.stack[#self.stack - n]
  end

  function instance:push(pushed)
    local stateInstance, current
    current = self:current()

    if current then
      current:leave()
    end

    stateInstance = pushed:new()
    stateInstance:load()
    stateInstance:enter()

    bishop.console:log("[bishop.state.stack/push] " .. pushed.name)
    table.insert(self.stack, stateInstance)
    return stateInstance
  end

  function instance:pop()
    local stateInstance = self:current()
    stateInstance:leave()
    stateInstance:unload()
    bishop.console:log("[bishop.state.stack/pop] " .. stateInstance.class.name)
    table.remove(self.stack)
    bishop.console:log("[bishop.state.stack/pop/enter]")
    self:current():enter()
    bishop.console:log("[bishop.state.stack/pop/over]")
  end

  function instance:replace(state)
    local stateInstance = self:current()

    if stateInstance then
      stateInstance:leave()
      stateInstance:unload()
      bishop.console:log("[bishop.state.stack/replace] " ..
        stateInstance.class.name .. " -> " .. state.name)
    else
      bishop.console:log("[bishop.state.stack/replace] -> " ..
        state.name)
    end

    table.remove(self.stack)
    stateInstance = state:new()
    stateInstance:load()
    stateInstance:enter()
    table.insert(self.stack, stateInstance)
    return stateInstance
  end
end)
