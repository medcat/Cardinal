define "bishop.game":
as(function(class, instance)

  instance.assets     = nil
  instance.effects    = nil
  instance.assets     = nil
  instance.maps       = nil
  instance.states     = nil
  instance.screen     = nil
  instance.controller = nil
  instance.console    = nil

  instance.stack      = nil

  -- By default, there is no current game.  This MUST be set by
  -- the programmer.
  class.current = nil

  function instance:initialize(name)
    self.assets  = {}
    self.effects = {}
    self.assets  = {}
    self.maps    = {}
    self.states  = {}
    self.name    = name
  end

  function instance:exit()
    love.event.quit()
  end

  function instance:starting()
    return self.states.mainMenu
  end

  function instance:load()
    self.screen     = bishop.screen:new()
    self.controller = bishop.controller.keyboard:new()
    self.console    = bishop.console:new()
    self.stack      = bishop.state.stack:new()

    self.console:log("[" .. self.name .. "] loaded.")
    self.screen:update()
    self.console:log(self.screen:output())
    self.stack:push(self:starting())
  end

  function instance:update(...)
    self.stack:current():update(...)
  end

  function instance:draw(...)
    local varg = ...
    self.screen:encapsulate(function()
      self.stack:current():draw(varg)
    end)
  end

  function instance:input(...)
    self.stack:current():input(...)
  end

  function instance:press(...)
    self.stack:current():press(...)
  end

  function instance:release(...)
    self.stack:current():release(...)
  end

  function instance:resize(...)
    love.graphics.clear()
    self.screen:refresh(...)
    self.stack:current():resize(...)
  end

end)
