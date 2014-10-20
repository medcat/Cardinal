define "cardinal.effects.backgroundColor": extends "bishop.effect":
as(function(class, instance)
  function instance:initialize(color)
    self.color = color
  end

  function instance:load()
    self.oldColor = {love.graphics.getBackgroundColor()}
  end

  function instance:beforeAll()
    love.graphics.setBackgroundColor(unpack(self.color))
  end

  function instance:afterAll()
    --love.graphics.setBackgroundColor(unpack(self.oldColor))
  end
end)
