Cardinal.Asset.Variant = class("Cardinal.Asset.Variant"):
  extends(Cardinal.Entity)
{
  path = nil,

  initialize = function(self, path)
    self.path = path
  end
}
