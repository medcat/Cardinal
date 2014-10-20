define "bishop.controller.keyboard": extends "bishop.controller":
as(function(class, instance)

  instance.binding = nil

  function instance:initialize()
    self.binding = {}
    setmetatable(self.binding, {__index=class.binding})
  end

  function instance:isPressed(name)
    local key = self.binding[name]
    assert(key, "No key is associated with ".. tostring(name))
    return love.keyboard.isDown(key)
  end

  class.binding =
  {
    ["moveleft"]  = "a",
    ["moveright"] = "d",
    ["moveup"]    = "w",
    ["movedown"]  = "s",
    ["select"]    = " ",
    ["cancel"]    = "tab",
    ["exit"]      = "escape",
    ["console"]   = "`",
  }

end)
