--[[
  This takes a drawable and smothers it (and only it) with an effect.
  This has the effect of only applying the effect to the drawable.
]]--
define "bishop.entity.capsule": extends "bishop.entity":
as(function(class, instance)

  function instance:initialize(drawable, effect, ...)
    if not drawable.isa or not drawable:isa(bishop.entity) then
      error("Expected entity")
    end

    if not effect.isa or not effect:isa(bishop.effect) then
      error("Expected effect")
    end

    self.drawable = drawable
    self.effect   = effect
    self.super.initialize(self, ...)
  end

  function instance:load(...)
    self.drawable:load(...)
    self.effect:load(...)
  end

  function instance:update(...)
    self.drawable:update(...)
  end

  function instance:draw()
    self.effect:beforeAll()
    self.effect:beforeEach(self.drawable)
    self.drawable:draw()
    self.effect:afterEach(self.drawable)
    self.effect:afterAll()
  end

  function instance:resize(...)
    self.drawable:resize(...)
  end

  function instance:input(...)
    self.drawable:input(...)
  end

  function instance:press(...)
    self.drawable:input(...)
  end

  function instance:release(...)
    self.drawable:input(...)
  end

end)
