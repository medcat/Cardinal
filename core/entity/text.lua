Cardinal.Entity.Text = class("Cardinal.Entity.Text"):
  extends(Cardinal.Entity)
{
  text = "",
  textColor = nil,

  initialize = function(self, text, ...)
    self.text = text
    self.textColor = {0, 0, 0}
    self.super.initialize(self, ...)
  end,

  draw = function(self)
    love.graphics.setColor(unpack(self.textColor))
    love.graphics.printf(self.text, self.coord.x, self.coord.y,
      Cardinal.Screen.current.internal.width - self.coord.x)
  end,
}
