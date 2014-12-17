define "cardinal.maps.intro": extends "bishop.map":
as(function(class, instance)

  class.path = "assets/intro"

  function instance:initialize()
    self.super.initialize(self)
    self.mapData = class._data
  end
end)
