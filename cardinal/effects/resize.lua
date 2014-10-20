cardinal.effects.resize = class("cardinal.effects.resize"):
  extends(bishop.effect)
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
