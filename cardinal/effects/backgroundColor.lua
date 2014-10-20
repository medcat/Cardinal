cardinal.effects.backgroundColor = class("cardinal.effects.backgroundColor"):
  extends(bishop.effect)
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
