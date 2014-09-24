Cardinal.Game.Effects.Resize = class("Cardinal.Game.Effects.Resize"):
  extends(Cardinal.Effect)
{
  initialize = function(self, screen)
    self.screen = screen
  end,

  --[[
  beforeAll = function(self)
    self.screen:enterEncapsulate()
  end,

  afterAll = function(self)
    self.screen:exitEncapsulate()
  end
  ]]--
}
