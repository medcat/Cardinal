Cardinal.Game.States.Console = class("Cardinal.Game.States.Console"):
  extends(Cardinal.State)
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

    self.inputBox = Cardinal.Entity.Text:new("", 0, 900 - 32)
    self.historyBox = Cardinal.Entity.Text:new("")
    self.inputBox.textColor = {255, 255, 255}
    self.historyBox.textColor = {255, 255, 255}
    self.historyBox.text = table.concat(Cardinal.Console.history, "\n")
    self.group:
      add({
        zindex = 0,
        initialize = function(self)
          self.super.initialize(self, 0, 0, 1600, 900)
        end,
        draw = function(self)
          love.graphics.setColor(0, 0, 0, 75)
          love.graphics.rectangle("fill", self.coord.x, self.coord.y,
            self.size.width, self.size.height)
        end
      }):
      add({
        zindex = -1,
        draw = function(this)
          Cardinal.Screen.current:dencapsulate(function()
            love.graphics.draw(self.screenshot, 0, 0)
          end)
        end,
      }):
      add(self.inputBox):
      add(self.historyBox):
      add(Cardinal.Game.Effects.Font, "assets/inconsolata.otf", 32):
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
      Cardinal.Console:log("> " .. self.line)

      status, func = loadstring(self.line)

      if status then
        status, val = pcall(status)
       if not status then err = val end
      else
        err = func
      end

      if err then
        Cardinal.Console:log("] error: " .. tostring(err))
      else
        Cardinal.Console:log("] " .. tostring(val))
      end

      self.line = ""
      self.inputBox.text = "> \x7c"
      self.historyBox.text = table.concat(Cardinal.Console.history, "\n")
    end
  end,

  release = function(self, k)
    if k == "`" then
      Cardinal.State.pop()
    end
  end,

  update = function(self, dt)
    self.inputBox.text = "> " .. self.line .. "\x7c"
    self.super.update(self, dt)

    if Cardinal.Controller.current:isPressed("exit") then
      love.event.quit()
    end
  end,
}

Cardinal.Console = {
  history = {},
  log = function(self, part)
    if #self.history > self.limit then
      self.history = { unpack(self.history, #self.history - self.limit, #self.history) }
    end

    table.insert(self.history, part)
  end,
  limit = 20,
}
