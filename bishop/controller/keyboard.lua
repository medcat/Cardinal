bishop.controller.keyboard = class("bishop.controller.keyboard"):
  extends(bishop.controller)
{
  keyBinding = nil,

  initialize = function(self)
    self.keyBinding = {}
    setmetatable(self.keyBinding, {__index=bishop.controller.keyboard.binding})
  end,

  isPressed = function(self, name)
    local key = self.keyBinding[name]
    assert(key, "No key is associated with ".. tostring(name))
    return love.keyboard.isDown(key)
  end,
}

bishop.controller.keyboard.binding =
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
