define "cardinal.states.inGame": extends "bishop.state":
as(function(class, instance)
  function instance:load()
    self.map = cardinal.maps.intro:new()
    self.group:
      add(self.map):
      addDefaults()
    self.super.load(self)
  end

  function instance:release(key)
    if key == "`" then
      cardinal.stack:push(cardinal.states.console)
    end
  end

  function instance:update(...)
    if cardinal.controller:isPressed("exit") then
      cardinal:exit()
    end

    self.super.update(self, ...)
  end
end)
