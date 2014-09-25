Cardinal.Game.States.InGame = class("Cardinal.Game.States.InGame"):
  extends(Cardinal.State)
{
  enter = function(self)
    local textEntity = Cardinal.Entity.Text:new("In Game", 800)
    textEntity.textColor = {255, 255, 255}
    self.group:
      add(textEntity):
      add(Cardinal.Game.Assets.duck):
      addDefaults()
    self.super.load(self)
  end,
}
