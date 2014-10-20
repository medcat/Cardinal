define "cardinal.states.console": extends "bishop.state":
as(function(class, instance)
  function instance:enter()
    love.keyboard.setTextInput(true)
    love.keyboard.setKeyRepeat(true)
    self.screenshot = love.graphics.newImage(love.graphics.newScreenshot())
    self.super.enter(self)
  end

  function instance:leave()
    love.keyboard.setTextInput(false)
    love.keyboard.setKeyRepeat(false)
    self.super.leave(self)
  end

  function instance:load()
    self.inputBox = bishop.entity.text:new("", 0,
      cardinal.screen.internal.height - 32)
    self.historyBox = bishop.entity.text:new("")
    self.inputBox.textColor = {255, 255, 255}
    self.historyBox.textColor = {255, 255, 255}

    self.group:
      add(function(_, inst)
        inst.zindex = 0

        function inst:initialize()
          self.super.initialize(self, 0, 0, 1600, 900)
        end

        function inst:draw()
          love.graphics.setColor(0, 0, 0, 175)
          love.graphics.rectangle("fill", self.coord.x, self.coord.y,
            self.size.width, self.size.height)
        end
      end):
      add(function(_, inst)
        inst.zindex = -1
        function inst.draw(this)
          cardinal.screen:dencapsulate(function()
            love.graphics.draw(self.screenshot, 0, 0)
          end)
        end
      end):
      add(self.inputBox):
      add(self.historyBox):
      add(cardinal.effects.font, "assets/anonpro.ttf", 34):
      addDefaults()

    self.line = ""
    self.super.load(self)
  end

  function instance:input(t)
    if t ~= "`" then
      self.line = self.line .. t
    end
  end

  function instance:press(k, r)
    local body, func, val, status, err = nil
    if k == "backspace" then
      self.line = string.sub(self.line, 1, -2)
    elseif k == "return" then
      if not self.line:find("return") then
        self.line = "return " .. self.line
      end

      cardinal.console:log("> " .. self.line)

      status, func = loadstring(self.line)

      if status then
        status, val = pcall(status)
       if not status then err = val end
      else
        err = func
      end

      if err then
        cardinal.console:log("] error: " .. tostring(err))
      else
        cardinal.console:log("] " .. tostring(val))
      end

      self.line = ""
      self.inputBox.text = "> \x7c"
      self.historyBox.text = table.concat(cardinal.console.history, "\n")
    end
  end

  function instance:release(k)
    if k == "`" then
      cardinal.stack:pop()
    end
  end

  function instance:update(dt)
    self.inputBox.text = "> " .. self.line .. "\x7c"
    self.historyBox.text = table.concat(cardinal.console.history, "\n")
    self.super.update(self, dt)

    if cardinal.controller:isPressed("exit") then
      love.event.quit()
    end
  end
end)
