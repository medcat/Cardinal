define "cardinal.effects.font": extends "bishop.effect":
as(function(class, instance)
  function instance:initialize(fontName, fontSize)
    self._fontData = {name=fontName,size=fontSize}
  end

  function instance:load()
    self.oldFont = love.graphics.getFont()
    self.font = love.graphics.newFont(self._fontData.name,
      self._fontData.size)
  end

  function instance:beforeEach()
    love.graphics.setFont(self.font)
  end

  function instance:afterEach()
    love.graphics.setFont(self.oldFont)
  end
end)
