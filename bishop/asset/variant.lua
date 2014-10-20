define "bishop.asset.variant": extends "bishop.entity":
as(function(class, instance)

  instance.path = nil

  function instance:initialize(path)
    self.path = path
  end
end)
