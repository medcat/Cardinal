cardinal.assets.duck = bishop.asset:new()
local duck = cardinal.assets.duck

duck.variants.default = define.anon("duck.variant.default"):
extends("bishop.asset.variant"): as(function(class, instance)
  function instance:initialize()
    self.super.initialize(self)
    self.path  = "assets/duck.jpg"
    self.coord = { x = 0, y = 200 }
    self.size  = {
      width    = 800,
      height   = 765
    }
  end

  function instance:load()
    self.image = love.graphics.newImage(self.path)
  end

  function instance:draw()
    love.graphics.draw(self.image)
  end
end):new()
