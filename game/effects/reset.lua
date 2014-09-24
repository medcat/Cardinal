Cardinal.Game.Effects.Reset = class("Cardinal.Game.Effects.Reset"):
  extends(Cardinal.Effect)
{
  beforeEach = function(self)
    love.graphics.push()
  end,

  afterEach = function(self)
    love.graphics.pop()
  end
}
