bishop.asset.variant = class("bishop.asset.variant"):
  extends(bishop.entity)
{
  path = nil,

  initialize = function(self, path)
    self.path = path
  end
}
