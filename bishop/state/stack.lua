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
    n = n - 1
    if n < 0 or n > #self.stack then
      error("Invalid value " .. n .. " passed!")
    end

    return self.stack[#self.stack - n]
  end

  --[[
    When pushing/popping/replacing states, this is the order:

    current:leave  -- if push, pop, replace
    current:unload -- if pop, replace
    table.remove   -- if pop, replace
    new:new        -- if push, replace
    new:load       -- if push, replace
    new:enter      -- if push, pop, replace
    table.insert   -- if push, replace
  ]]--

  -- temporarily takes us out of the current state.
  function instance:temp(func)
    local current, old
    current = self:current()
    current:leave()
    table.remove(self.stack)
    old = self:current()
    old:enter()
    func(current, old)
    old:leave()
    current:enter()
    table.insert(self.stack, current)
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
