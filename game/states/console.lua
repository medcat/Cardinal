local backgroundRectangle = class("<anon>.background.rectangle"):
  extends(Cardinal.Entity)
{
  zindex = 0,
  initialize = function(self)
    self.super.initialize(self, 0, 0, 1600, 900)
  end,
  draw = function(self)
    love.graphics.setColor(0, 0, 0, 75)
    love.graphics.rectangle("fill", self.coord.x, self.coord.y,
      self.size.width, self.size.height)
  end
}

Cardinal.Game.States.Console = class("Cardinal.Game.States.Console"):
  extends(Cardinal.State)
{
  enter = function(self)
    love.mouse.setGrabbed(false)
    love.mouse.setVisible(true)
    love.keyboard.setTextInput(true)
    love.keyboard.setKeyRepeat(true)
    local screenshot = love.graphics.newScreenshot()

    self.inputBox = Cardinal.Entity.Text:new("", 0, 900 - 32)
    self.historyBox = Cardinal.Entity.Text:new("")
    self.inputBox.textColor = {255, 255, 255}
    self.historyBox.textColor = {255, 255, 255}

    self.group:
      add(backgroundRectangle:new()):
      add(self.inputBox):
      add(self.historyBox):
      add(Cardinal.Game.Effects.Font:new("assets/inconsolata.otf", 32)):
      addDefaults()

    self.super.enter(self)
    self.history = {}
    self.line = ""
  end,

  input = function(self, t)
    self.line = self.line .. t
  end,

  press = function(self, k, r)
    local body, func, val, status
    if k == "backspace" then
      self.line = string.sub(self.line, 1, -2)
    elseif k == "return" then
      print("ENTER!")
      table.insert(self.history, self.line)
      status, func = pcall(loadstring("function __exec__()\nreturn (" ..
        self.line .. ")\nend"))
      if status then
        status, val = pcall(__exec__)
      end

      if status then
        table.insert(self.history, "] " .. tostring(val))
      else
        table.insert(self.history, "] Error: " .. tostring(val))
      end

      self.line = ""
      self.inputBox.text = "> "
      self.historyBox.text = table.concat(self.history, "\n")
    end
  end,

  release = function(self, k)
    if k == "`" then
      Cardinal.State.transitionTo(Cardinal.Game.States.MainMenu)
    end
  end,

  update = function(self, dt)
    self.inputBox.text = "> " .. self.line
    self.super.update(self, dt)

    if Cardinal.Controller.current:isPressed("exit") then
      love.event.quit()
    end
  end,
}
