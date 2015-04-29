define "bishop.screen":
as(function(class, instance)
  instance.real = nil
  instance.size = nil
  instance.offset = nil
  instance.internal = nil
  instance.scale = 0.0

  -- x: relative to width
  -- y: relative to height

  function instance:initialize()
    self.internal = { width = 1600, height = 900 }
    self.offset = { x = 0, y = 0 }
    self.real = { width = 0, height = 0 }
    self.size = { width = 0, height = 0 }
  end

  table.merge(bishop.save.defaults.config, {
    screen = {
      width  = 800,
      height = 600,
      fullscreen = false
    }
  })

  -- Loads the data from the Save file.
  function instance:load()
    local screenData = bishop.save.config.screen
    love.window.setMode(screenData.width, screenData.height,
      { fullscreen = screenData.fullscreen, resizable = true })
  end

  function instance:update()
    local width, height
    width, height = love.window.getMode()
    if self.real.width == width and self.real.height == height then
      return self
    else
      return self:refresh(width, height)
    end
  end

  function instance:refresh(realWidth, realHeight)
    local horizontalScale, verticalScale, newSize

    self.real.width = realWidth
    self.real.height = realHeight
    horizontalScale = realWidth / self.internal.width
    verticalScale = realHeight / self.internal.height

    if horizontalScale < verticalScale then
      -- In this case, we have to scale down the width because our
      -- "perfect screen" is too wide for the host.  We'll also have
      -- to have an offset vertically.
      self.scale = horizontalScale
    else
      -- In this case, we have to scale down our height because our
      -- "perfect screen" is too high for the host.  We'll also have
      -- to have an offset horizontally.
      self.scale = verticalScale
    end

    self.size = {
      width  = math.floor(self.internal.width * self.scale),
      height = math.floor(self.internal.height * self.scale)
    }
    -- these will be our offsets.  woop.
    self.offset.x = (math.abs(self.size.width - realWidth) / 2)
    self.offset.y = (math.abs(self.size.height - realHeight) / 2)

    return self
  end

  function instance:output()
    return "[screen] scale: " .. self.scale .. " " ..
      "\nreal: (" .. self.real.width .. ", " .. self.real.height .. ") " ..
      "\noffset: (" .. self.offset.x .. ", " .. self.offset.y    .. ") " ..
      "\nnew: (" ..  self.size.width .. ", " .. self.size.height .. ") "
  end

  function instance:encapsulate(func, ...)
    self:enterEncapsulate()
    func(...)
    self:exitEncapsulate()
  end

  function instance:enterEncapsulate()
    love.graphics.push()
    love.graphics.translate(self.offset.x, self.offset.y)
    love.graphics.scale(self.scale)
    love.graphics.setScissor(self.offset.x, self.offset.y,
      self.size.width, self.size.height)
  end

  function instance:exitEncapsulate()
    love.graphics.pop()
    love.graphics.setScissor()
  end

  function instance:dencapsulate(func, ...)
    self:enterDencapsulate()
    func(...)
    self:exitDencapsulate()
  end

  function instance:enterDencapsulate()
    love.graphics.push()
    love.graphics.origin()
    love.graphics.setScissor()
  end

  function instance:exitDencapsulate()
    love.graphics.pop()
    love.graphics.setScissor(self.offset.x, self.offset.y,
      self.size.width, self.size.height)
  end
end)
