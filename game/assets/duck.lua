Cardinal.Game.Assets.duck = Cardinal.Asset:new()
local duck = Cardinal.Game.Assets.duck

duck.variants.default = class("duck.variants.default"):
  extends(Cardinal.Asset.Variant)
{
  initialize = function(self)
    self.super.initialize(self)
    self.path  = "assets/duck.jpg"
    self.coord = { x = 0, y = 0 }
    self.size  = {
      width    = 800,
      height   = 765
    }
  end,

  load = function(self)
    self.duck = love.graphics.newImage(self.path)
  end,

  draw = function(self)
    love.graphics.draw(self.duck)
  end

}:new()
