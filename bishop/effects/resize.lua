define "bishop.effects.resize": extends "bishop.effect":
as(function(class, instance)
  function instance:initialize(encap)
    self.encap = encap
  end

  function instance:beforeAll()
    if encap then
      bishop.game.current.screen:enterEncapsulate()
    else
      bishop.game.current.screen:enterDencapsulate()
    end
  end

  function instance:afterAll()
    if encap then
      bishop.game.current.screen:exitEncapsulate()
    else
      bishop.game.current.screen:exitDencapsulate()
    end
  end

end)
