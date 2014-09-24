Cardinal.Entity = class("Cardinal.Entity"):
  extends(Cardinal.Drawable)
{
  coord = nil,
  size = nil,

  initialize = function(self, x, y, width, height)
    self.coord = { x = x or 0, y = y or 0 }
    self.size  = { width = width or 0, height = height or 0 }
  end,
}

require "core.entity.group"
require "core.entity.text"
