define "bishop.entity": extends "bishop.drawable":
as(function(class, instance)
  instance.coord = nil
  instance.size = nil

  function instance:initialize(x, y, width, height)
    self.coord = { x = x or 0, y = y or 0 }
    self.size  = { width = width or 0, height = height or 0 }
  end

  function instance:resize() end
  function instance:input() end
  function instance:press() end
  function instance:release() end
end)

require "bishop.entity.group"
require "bishop.entity.text"
