local background = class("<anon>.background") : extends(Cardinal.Entity)
{
  load = function(self) self.zindex = 0 end,
  draw = function(self)
    local screen = Cardinal.Screen.current
    love.graphics.setColor(255, 0, 0)
    love.graphics.rectangle("fill", 0, 0, screen.internal.width, screen.internal.height)
  end,
}

Cardinal.Game.States.MainMenu = class("Cardinal.Game.States.MainMenu"):
  extends(Cardinal.State)
{
  load = function(self)
    love.mouse.setGrabbed(true)
    love.mouse.setVisible(false)
    love.keyboard.setTextInput(false)
    self.group:
      add(Cardinal.Entity.Text:new("Main Menu", 800)):
      add(background:new()):
      add(Cardinal.Game.Effects.Font:new("assets/yoster.ttf", 24)):
      addDefaults()
    self.super.load(self)
  end,

  leave = function(self)
    love.mouse.setGrabbed(false)
    love.mouse.setVisible(true)
  end,

  release = function(self, k)
    if k == "`" then
      Cardinal.State.transitionTo(Cardinal.Game.States.Console)
    elseif k == "c" then
      Cardinal.State.transitionTo(Cardinal.Game.States.InGame)
    end
  end,

  update = function(self, dt)
    if Cardinal.Controller.current:isPressed("exit") then
      love.event.quit()
    end
  end,
}
