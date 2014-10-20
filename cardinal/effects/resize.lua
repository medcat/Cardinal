define "cardinal.effects.resize": extends "bishop.effect":
as(function(class, instance)
  function instance:initialize(screen)
    self.screen = screen
  end

  --[[
  function instance:beforeAll()
    self.screen:enterEncapsulate()
  end,

  function instance:afterAll()
    self.screen:exitEncapsulate()
  end
  ]]--
end)
