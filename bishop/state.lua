define "bishop.state": extends "bishop.entity":
as(function(class, instance)

  instance.group = nil

  function instance:initialize()
    self.group = bishop.entity.group:new()
  end

  function instance:load()
    self.group:load()
  end

  function instance:unload()
  end

  -- This is called when the state is entered; this is different
  -- than the load function, because that is called when the
  -- state is created.  Enter is called after load.
  function instance:enter()
  end

  -- This is called when the state is left; the state may not be
  -- unloaded after the leave.  It is called before unload.
  function instance:leave()
  end

  function instance:draw()
    self.group:draw()
  end

  function instance:update(dt)
    self.group:update(dt)
  end

  function instance:resize(w, h)
  end

  function instance:pause()
    self.paused = true
  end

  function instance:unpause()
    self.paused = nil
  end
end)

require "bishop.state.stack"
