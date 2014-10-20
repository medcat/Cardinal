cardinal.states.inGame = class("cardinal.states.inGame"):
  extends(bishop.state)
{

  load = function(self)
    self.map = cardinal.maps.intro:new()
    self.group:
      add(self.map):
      addDefaults()
    self.super.load(self)
  end,

  release = function(self, key)
    if key == "`" then
      bishop.state.push(cardinal.states.console)
    end
  end,
}
