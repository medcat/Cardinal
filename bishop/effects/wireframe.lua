define "bishop.effects.wireframe": extends "bishop.effect":
as(function(class, instance)

  function instance:beforeEach()
    love.graphics.setWireframe(true)
  end

  function instance:afterEach()
    love.graphics.setWireframe(false)
  end

end)
