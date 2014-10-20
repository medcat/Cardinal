bishop.entity.text = class("bishop.entity.text"):
  extends(bishop.entity)
{
  text = "",
  textColor = nil,
  wrap = false,

  initialize = function(self, text, ...)
    self.text = text
    self.textColor = {0, 0, 0}
    self.super.initialize(self, ...)
  end,

  draw = function(self)
    local r, g, b, a
    r, g, b, a = love.graphics.getColor()
    love.graphics.setColor(unpack(self.textColor))
    if self.wrap then
      love.graphics.printf(self.text, self.coord.x, self.coord.y,
        bishop.screen.current.internal.width - self.coord.x)
    else
      love.graphics.print(self.text, self.coord.x, self.coord.y)
    end
    love.graphics.setColor(r, g, b, a)
  end,
}
