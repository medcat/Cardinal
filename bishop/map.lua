define "bishop.map": extends "bishop.entity":
as(function(class, instance)

  instance.offset = nil
  class.path = ""

  function instance:initialize()
    self.map = lib.sti.new(self.class.path)
  end

  function instance:update(dt)
    self.map:update(dt)
  end

  function instance:draw()
    local translate = { x = 0, y = 0 }
    self.map:setDrawRange(translate.x, translate.y,
        cardinal.screen.internal.width, cardinal.screen.internal.height)
    self.map:draw()
  end
end)
