Cardinal.Map = class("Cardinal.Map"):
  extends(Cardinal.Entity)
{
  mapData = nil,
  position = nil,

  initialize = function(self)
    self.position = { x = 0, y = 0 }
  end,

  load = function(self)
    local image, row, col, tile
    self.mapData.set.image = love.graphics.newImage("assets/main.jpg")
    image = self.mapData.set.image

    for i, v in ipairs(self.mapData.tiles) do
      row = math.floor((i - 1) / self.mapData.set.width)
      col = (i % self.mapData.set.width) - 1
      if col < 0 then col = self.mapData.set.width + col end
      v.quad = love.graphics.newQuad(
        col * (self.mapData.set.size + 1),
        row * (self.mapData.set.size + 1),
        self.mapData.set.size - 2,
        self.mapData.set.size - 2,
        image:getDimensions())
    end

    self.spritebatch = love.graphics.newSpriteBatch(image)
    self.spritebatch:bind()
    for y, a in ipairs(self.mapData.layers[1]) do
      for x, v in ipairs(a) do
        tile = self.mapData.tiles[v]
        self.spritebatch:add(tile.quad,
          (x - 1) * (self.mapData.set.size - 2), (y - 1) * (self.mapData.set.size - 2))
      end
    end
    self.spritebatch:unbind()
  end,

  draw = function(self)
    love.graphics.draw(self.spritebatch)
  end,
}
