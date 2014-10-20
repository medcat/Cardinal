define "cardinal.states.mainMenu": extends "bishop.state":
as(function(class, instance)
  function instance:load()
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
  end

  function instance:enter()
    love.mouse.setGrabbed(true)
    love.mouse.setVisible(false)
    self.super.enter(self)
  end

  function instance:leave()
    love.mouse.setGrabbed(false)
    love.mouse.setVisible(true)
    self.super.leave(self)
  end

  function instance:release(k)
    if k == "`" then
      bishop.state.push(cardinal.states.console)
    elseif k == "c" then
      bishop.state.push(cardinal.states.inGame)
    end
  end

  function instance:update(dt)
    if bishop.controller.current:isPressed("exit") then
      love.event.quit()
    end
  end

end)
