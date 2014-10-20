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
      bishop.state.push(cardinal.states.console)
    end
  end
end)
