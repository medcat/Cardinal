bishop.entity = class("bishop.entity"):
  extends(bishop.drawable)
{
  coord = nil,
  size = nil,

  initialize = function(self, x, y, width, height)
    self.coord = { x = x or 0, y = y or 0 }
    self.size  = { width = width or 0, height = height or 0 }
  end,
}

require "bishop.entity.group"
require "bishop.entity.text"
