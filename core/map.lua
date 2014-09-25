Cardinal.Map = class("Cardinal.Map"):
  extends(Cardinal.Entity)
{
  mapData = nil,
  position = nil,

  initialize = function(self)
    position = { x = 0, y = 0 }
  end,

  load = function(self)
    self.image =
      love.graphics.newImage("assets/main.png")
  --[[
    local image, row, col, tile
    self.canvas = love.graphics.newCanvas()
    image = self.mapData.set.image
    print(image)
    for i, v in ipairs(self.mapData.tiles) do
      row = math.floor((i - 1) / self.mapData.set.width)
      col = (i % self.mapData.set.width) - 1
      if col < 0 then col = self.mapData.set.width + col end
      v.quad = love.graphics.newQuad(col * self.mapData.set.size,
        row * self.mapData.set.size, self.mapData.set.size,
        self.mapData.set.size, image:getWidth(), image:getHeight())
    end

    self.spritebatch = love.graphics.newSpriteBatch(image)
    self.spritebatch:bind()
    for y, a in ipairs(self.mapData.layers[1]) do
      for x, v in ipairs(a) do
        tile = self.mapData.tiles[v]
        print("adding sprite at " .. (x * self.mapData.set.size) .. ", " .. (y * self.mapData.set.size) .. " ")
        self.spritebatch:add(tile.quad, (x - 1) * self.mapData.set.size, (y - 1) * self.mapData.set.size)
      end
    end
    self.spritebatch:unbind()
  ]]
  end,

  update = function(self, dt)

  end,

  draw = function(self)
    --self.canvas:clear()
    --love.graphics.setCanvas(self.canvas)
    --love.graphics.draw(self.spritebatch)
    --love.graphics.setCanvas()
    --love.graphics.draw(self.canvas)
    love.graphics.draw(self.image, 0, 0)
    --love.graphics.setColor(255, 0, 0)
    --love.graphics.rectangle("fill", 0, 0, 600, 600)
  end,
}
