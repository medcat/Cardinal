Cardinal.Screen = class("Cardinal.Screen")
{
  real = nil,
  size = nil,
  offset = nil,
  internal = nil,
  scale = 0.0,

  -- x: relative to width
  -- y: relative to height

  initialize = function(self)
    self.internal = { width = 1600, height = 900 }
    self.offset = { x = 0, y = 0 }
    self.real = { width = 0, height = 0 }
    self.size = { width = 0, height = 0 }
  end,

  update = function(self)
    local width, height
    width, height = love.window.getMode()
    if self.real.width == width and self.real.height == height then
      return self
    else
      return self:refresh(width, height)
    end
  end,

  refresh = function(self, realWidth, realHeight)
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
  end,

  output = function(self)
    return "scale: " .. self.scale .. " " ..
      "real: (" .. self.real.width .. ", " .. self.real.height .. ") " ..
      "offset: (" .. self.offset.x .. ", " .. self.offset.y    .. ") " ..
      "new: (" ..  self.size.width .. ", " .. self.size.height .. ") "
  end,

  translate = function(self, coordinate)
    local realX, realY
    if coordinate.realCoordinate then
      return coordinate
    else
      realX = ((coordinate.x / self.width) * self.realWidth)
      realY = ((coordinate.y / self.height) * self.realHeight)
      return Cardinal.Screen.Coordinate:new(realX, realY, true)
    end
  end,

  encapsulate = function(self, func, ...)
    self:enterEncapsulate()
    func(...)
    self:exitEncapsulate()
  end,

  enterEncapsulate = function(self)
    love.graphics.push()
    love.graphics.scale(self.scale)
    love.graphics.translate(self.offset.x, self.offset.y * 2)
  end,

  exitEncapsulate = function(self)
    love.graphics.pop()
  end,
}
