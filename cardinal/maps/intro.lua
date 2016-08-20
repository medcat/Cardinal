define "cardinal.maps.intro": extends "bishop.map":
as(function(class, instance)

  class.path = "assets/intro.lua"

  function instance:initialize()
    self.super.initialize(self)
  end
end)
