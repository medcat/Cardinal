cardinal.states.console = class("cardinal.states.console"):
  extends(bishop.state)
{
  enter = function(self)
    love.keyboard.setTextInput(true)
    love.keyboard.setKeyRepeat(true)
    self.screenshot = love.graphics.newImage(love.graphics.newScreenshot())
    self.super.enter(self)
  end,

  leave = function(self)
    love.keyboard.setTextInput(false)
    love.keyboard.setKeyRepeat(false)
    self.super.leave(self)
  end,

  load = function(self)
    self.inputBox = bishop.entity.text:new("", 0,
      bishop.screen.current.internal.height - 32)
    self.historyBox = bishop.entity.text:new("")
    self.inputBox.textColor = {255, 255, 255}
    self.historyBox.textColor = {255, 255, 255}

    self.group:
      add({
        zindex = 0,
        initialize = function(self)
          self.super.initialize(self, 0, 0, 1600, 900)
        end,
        draw = function(self)
          love.graphics.setColor(0, 0, 0, 125)
          love.graphics.rectangle("fill", self.coord.x, self.coord.y,
            self.size.width, self.size.height)
        end
      }):
      add({
        zindex = -1,
        draw = function(this)
          bishop.screen.current:dencapsulate(function()
            love.graphics.draw(self.screenshot, 0, 0)
          end)
        end,
      }):
      add(self.inputBox):
      add(self.historyBox):
      add(cardinal.effects.font, "assets/inconsolata.otf", 32):
      addDefaults()

    self.line = ""
    self.super.load(self)
  end,

  input = function(self, t)
    if t ~= "`" then
      self.line = self.line .. t
    end
  end,

  press = function(self, k, r)
    local body, func, val, status, err = nil
    if k == "backspace" then
      self.line = string.sub(self.line, 1, -2)
    elseif k == "return" then
      if not self.line:find("return") then
        self.line = "return " .. self.line
      end

      bishop.console:log("> " .. self.line)

      status, func = loadstring(self.line)

      if status then
        status, val = pcall(status)
       if not status then err = val end
      else
        err = func
      end

      if err then
        bishop.console:log("] error: " .. tostring(err))
      else
        bishop.console:log("] " .. tostring(val))
      end

      self.line = ""
      self.inputBox.text = "> \x7c"
      self.historyBox.text = table.concat(bishop.console.history, "\n")
    end
  end,

  release = function(self, k)
    if k == "`" then
      bishop.state.pop()
    end
  end,

  update = function(self, dt)
    self.inputBox.text = "> " .. self.line .. "\x7c"
    self.historyBox.text = table.concat(bishop.console.history, "\n")
    self.super.update(self, dt)

    if bishop.controller.current:isPressed("exit") then
      love.event.quit()
    end
  end,
}
