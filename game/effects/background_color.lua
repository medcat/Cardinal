Cardinal.Game.Effects.BackgroundColor = class("Cardinal.Game.Effects.BackgroundColor"):
  extends(Cardinal.Effect)
{
  initialize = function(self, color)
    self.color = color
  end,

  load = function(self)
    self.oldColor = {love.graphics.getBackgroundColor()}
  end,

  beforeAll = function(self)
    love.graphics.setBackgroundColor(unpack(self.color))
  end,

  afterAll = function(self)
    --love.graphics.setBackgroundColor(unpack(self.oldColor))
  end,
}
