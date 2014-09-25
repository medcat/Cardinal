Cardinal.State = class("Cardinal.State"):
  extends(Cardinal.Drawable)
{
  group = nil,

  initialize = function(self)
    self.group = Cardinal.Entity.Group:new()
  end,

  load = function(self)
    self.group:load()
  end,

  enter = function(self) self:load() end,
  leave = function(self) end,

  draw = function(self)
    self.group:draw()
  end,

  update = function(self, dt)
    self.group:update(dt)
  end,

  input = function(self) end,
  press = function(self) end,
  release = function(self) end,
}

Cardinal.State.current = nil

Cardinal.State.transitionTo = function(to)
  local stateInstance
  if Cardinal.State.current then
    Cardinal.State.current:leave()
  end

  stateInstance = to:new()
  stateInstance:enter()
  love.graphics.clear()
  Cardinal.State.current = stateInstance
end
