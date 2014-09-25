Cardinal.Game.States.MainMenu = class("Cardinal.Game.States.MainMenu"):
  extends(Cardinal.State)
{
  load = function(self)
    self.group:
      add(Cardinal.Entity.Text, "Main Menu", 800):
      add({
        load = function(self)
          self.zindex = 0
        end,

        draw = function(self)
          local screen = Cardinal.Screen.current
          love.graphics.setColor(255, 0, 0)
          love.graphics.rectangle("fill", 0, 0, screen.internal.width, screen.internal.height)
        end,
      }):
      add(Cardinal.Game.Effects.Font, "assets/yoster.ttf", 24):
      addDefaults()
    self.super.load(self)
  end,

  enter = function(self)
    love.mouse.setGrabbed(true)
    love.mouse.setVisible(false)
    self.super.enter(self)
  end,

  leave = function(self)
    love.mouse.setGrabbed(false)
    love.mouse.setVisible(true)
    self.super.leave(self)
  end,

  release = function(self, k)
    if k == "`" then
      Cardinal.State.push(Cardinal.Game.States.Console)
    elseif k == "c" then
      Cardinal.State.replace(Cardinal.Game.States.InGame)
    end
  end,

  update = function(self, dt)
    if Cardinal.Controller.current:isPressed("exit") then
      love.event.quit()
    end
  end,
}
