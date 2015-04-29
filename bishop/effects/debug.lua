define "bishop.effects.debug": extends "bishop.effect":
as(function(class, instance)
  function instance:initialize(name, enabled)
    self.name = name or ""
    self.enabled = enabled
  end

  function instance:load()
    if not self.enabled then return end
    bishop.game.current.console:log("[bishop.effect.debug/" ..
      self.name .. "] loaded")
  end

  function instance:beforeAll()
    if not self.enabled then return end
    bishop.game.current.console:log("[bishop.effect.debug/" ..
      self.name .. "] beforeAll")
  end

  function instance:afterAll()
    if not self.enabled then return end
    bishop.game.current.console:log("[bishop.effect.debug/" ..
      self.name .. "] afterAll")
  end

  function instance:beforeEach(drawable)
    if not self.enabled then return end
    bishop.game.current.console:log("[bishop.effect.debug/" ..
      self.name .. "] beforeEach " .. tostring(drawable))
  end

  function instance:afterEach(drawable)
    if not self.enabled then return end
    bishop.game.current.console:log("[bishop.effect.debug/" ..
      self.name .. "] afterEach " .. tostring(drawable))
  end
end)
