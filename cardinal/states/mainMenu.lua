cardinal.states.mainMenu = class("cardinal.states.mainMenu"):
  extends(bishop.state)
{
  load = function(self)
    self.group:
      add(bishop.entity.text, "Main Menu", 800):
      add({
        load = function(self)
          self.zindex = 0
        end,

        draw = function(self)
          local screen = bishop.screen.current
          love.graphics.setColor(255, 255, 255)
          love.graphics.rectangle("fill", 0, 0, screen.internal.width, screen.internal.height)
        end,
      }):
      add(cardinal.assets.duck):
      add(cardinal.effects.font, "assets/yoster.ttf", 24):
      add(cardinal.effects.backgroundColor, {255, 255, 255, 255}):
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
      bishop.state.push(cardinal.states.console)
    elseif k == "c" then
      bishop.state.push(cardinal.states.inGame)
    end
  end,

  update = function(self, dt)
    if bishop.controller.current:isPressed("exit") then
      love.event.quit()
    end
  end,
}
