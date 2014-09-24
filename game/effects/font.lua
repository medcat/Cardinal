Cardinal.Game.Effects.Font = class("Cardinal.Game.Effects.Font"):
  extends(Cardinal.Effect)
{
  initialize = function(self, fontName, fontSize)
    self._fontData = {name=fontName,size=fontSize}
  end,

  load = function(self)
    self.oldFont = love.graphics.getFont()
    self.font = love.graphics.newFont(self._fontData.name,
      self._fontData.size)
  end,

  beforeEach = function(self)
    love.graphics.setFont(self.font)
  end,

  afterEach = function(self)
    love.graphics.setFont(self.oldFont)
  end,
}
