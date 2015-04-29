define "bishop.entity.text": extends "bishop.entity":
as(function(class, instance)
  instance.text = ""
  instance.textColor = nil
  instance.wrap = false
  instance.max = nil

  function instance:initialize(text, ...)
    self.text = text
    self.textColor = {0, 0, 0}
    self.max = bishop.game.current.screen.internal.width
    self.super.initialize(self, ...)
  end

  function instance:draw()
    local r, g, b, a
    r, g, b, a = love.graphics.getColor()
    love.graphics.setColor(unpack(self.textColor))
    if self.wrap then
      love.graphics.printf(self.text, self.coord.x, self.coord.y,
        self.max - self.coord.x)
    else
      love.graphics.print(self.text, self.coord.x, self.coord.y)
    end
    love.graphics.setColor(r, g, b, a)
  end
end)
