define "bishop.map.tiled": extends "bishop.entity":
as(function(class, instance)

  instance.data = nil
  instance.images = nil

  function instance:initialize(path)
    local chunk, result

    chunk = love.filesystem.load(path)
    result = chunk()

    self.data = result
  end

  function instance:load()
    local image
    for i, v in ipairs(self.data.tilesets) do
      image = love.graphics.newImage("assets/" .. v.image)
      v._image = image
    end
  end

  function instance:draw()

  end

end)
