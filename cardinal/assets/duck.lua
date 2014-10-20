--[[cardinal.assets.duck = bishop.asset:new()
local duck = cardinal.assets.duck

duck.variants.default = class("duck.variants.default"):
  extends(bishop.asset.variant)
{
  initialize = function(self)
    self.super.initialize(self)
    self.path  = "assets/duck.jpg"
    self.coord = { x = 0, y = 200 }
    self.size  = {
      width    = 800,
      height   = 765
    }
  end,

  load = function(self)
    self.image = love.graphics.newImage(self.path)
  end,

  draw = function(self)
    love.graphics.draw(self.image)
  end,

}:new()
]]
