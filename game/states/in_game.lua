Cardinal.Game.States.InGame = class("Cardinal.Game.States.InGame"):
  extends(Cardinal.State)
{

  load = function(self)
    self.map = Cardinal.Game.Maps.Intro:new()
    self.group:
      add(self.map):
      addDefaults()
    self.super.load(self)
  end,

  release = function(self, key)
    if key == "`" then
      Cardinal.State.push(Cardinal.Game.States.Console)
    end
  end,
}
