define "bishop.map": extends "bishop.entity":
as(function(class, instance)

  class.path = ""
  instance.translate = nil

  function instance:initialize()
    local internal = cardinal.screen.internal

    self.translate = { x = 0, y = 0 }
    self._map = lib.sti(self.class.path)
    self._map:resize(internal.width, internal.height)
  end

  function instance:load()
  end

  function instance:draw(...)
    local width = cardinal.screen.internal.width
    local height = cardinal.screen.internal.height
    love.graphics.push()
    love.graphics.translate(self.translate.x, self.translate.y)
    self._map:setDrawRange(self.translate.x, self.translate.y, width, height)
    self._map:draw(...)
    love.graphics.pop()
  end

  function instance:update(dt)
    self.translate.x = self.translate.x - 30 * dt
    self.translate.y = self.translate.y - 30 * dt
    self._map:update(dt)
  end

end)
