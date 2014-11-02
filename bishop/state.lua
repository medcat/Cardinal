define "bishop.state": extends "bishop.entity":
as(function(class, instance)

  instance.group = nil

  function instance:initialize()
    self.group = bishop.entity.group:new()
  end

  function instance:load()
    bishop.console:log("[state] load " .. self.class.name)
    self.group:load()
  end

  function instance:unload()
    bishop.console:log("[state] unload " .. self.class.name)
  end

  -- This is called when the state is entered; this is different
  -- than the load function, because that is called when the
  -- state is created.  Enter is called after load.
  function instance:enter()
    bishop.console:log("[state] enter " .. self.class.name)
  end

  -- This is called when the state is left; the state may not be
  -- unloaded after the leave.  It is called before unload.
  function instance:leave()
    bishop.console:log("[state] leave " .. self.class.name)
  end

  function instance:draw()
    self.group:draw()
  end

  function instance:update(dt)
    self.group:update(dt)
  end

  function instance:resize(w, h)
    bishop.console:log("[state] resize " .. "(" .. w .. ", "
      .. h .. ")")
  end
end)

require "bishop.state.stack"
