Cardinal.Controller.Keyboard = class("Cardinal.Controller.Keyboard"):
  extends(Cardinal.Controller)
{
  keyBinding = nil,

  initialize = function(self)
    self.keyBinding = {}
    setmetatable(self.keyBinding, {__index=Cardinal.Controller.Keyboard.keyBinding})
  end,

  isPressed = function(self, name)
    local key = self.keyBinding[name]
    assert(key, "No key is associated with ".. tostring(name))
    return love.keyboard.isDown(key)
  end,
}

Cardinal.Controller.Keyboard.keyBinding =
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
