define "bishop.effects.font": extends "bishop.effect":
as(function(class, instance)

  instance.name = ""
  instance.size = 12
  instance.data = nil
  instance.old  = nil

  function instance:initialize(name, size)
    self.name = name
    self.size = size
  end

  function instance:load()
    self.old = love.graphics.getFont()
    if self.name == nil then
      self.data = love.graphics.newFont(self.size)
    else
      self.data = love.graphics.newFont(self.name,
        self.size)
    end
  end

  function instance:beforeEach()
    love.graphics.setFont(self.data)
  end

  function instance:afterEach()
    love.graphics.setFont(self.old)
  end
end)
