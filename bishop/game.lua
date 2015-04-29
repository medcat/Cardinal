define "bishop.game":
as(function(class, instance)

  local BISHOP_MESSAGE = [[
[bishop] Bishop version ]] .. bishop.version .. [[

[bishop]
[bishop] Bishop is licensed under the MIT license, and
[bishop] therefore is completely free to use under any
[bishop] purpose, personal or commercial.  For more
[bishop] information, contact redjazz96@gmail.com.]]

  instance.assets     = nil
  instance.effects    = nil
  instance.assets     = nil
  instance.maps       = nil
  instance.states     = nil
  instance.screen     = nil
  instance.controller = nil
  instance.console    = nil

  instance.stack      = nil
  instance.meter      = 32

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

    bishop.save:loadSaveData()
    self.screen:load()
    self.console:log(BISHOP_MESSAGE)
    self.console:log("[bishop] game \"" .. self.name .. "\" loaded.")
    self.screen:update()
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
