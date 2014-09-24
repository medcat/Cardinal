Cardinal.Map = class("Cardinal.Map")
{
  mapData = nil,
  position = nil,

  initialize = function(self--[[, path]])
    position = { x = 0, y = 0 }
    --assert(love.filesystem.load(path))()
    --self.mapData = deserialize_()
  end,

  load = function(self)
    local image = self.mapData.set.image =
      love.graphics.newImage(self.mapData.set.path),
      spritebuffer, row, col
    for i, v in ipairs(self.mapData.tiles) do
      row = math.floor(self.mapData.set.height / i)
      col = self.mapData.set.width % i
      v.quad = love.graphics.newQuad(row * self.mapData.set.size,
        col * self.mapData.set.size, self.mapDaata.set.size,
        self.mapData.set.size, image:getWidth(), image:getHeight())
    end

    spritebuffer = love.graphics.newSpriteBuffer(image)
  end,

  draw = function(self)

  end,
}
