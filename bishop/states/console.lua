define "bishop.states.console": extends "bishop.state":
as(function(class, instance)

  instance.inputHistory = nil
  instance.font = nil

  local backgroundBlock = define.
    anon "<console>.backgroundBlock":
    extends "bishop.entity": as(function(class, instance)

    instance.zindex = 0

    function instance:initialize(console)
      self.console = console
      self.super.initialize(self, 0, 0, console.size.width,
        console.size.height)
    end

    function instance:draw()
      love.graphics.setColor(0, 0, 0, 220)
      love.graphics.rectangle("fill", self.coord.x, self.coord.y,
        self.size.width, self.size.height)
    end

  end)

  local screenshotDraw = define.
    anon "<console>.screenshotDraw":
    extends "bishop.entity": as(function(class, instance)

    instance.zindex = -1

    function instance:initialize(console)
      self.console = console
    end

    function instance:draw()
      if self.console.screenshot == nil then
        self.console:_screenshot()
      end

      love.graphics.draw(self.console.screenshot, 0, 0)
    end

  end)

  function instance:initialize(font)
    self.font = { data = nil, name = font, size = 21 }
    self.super.initialize(self)
    self.size = {}
  end

  function instance:enter()
    love.keyboard.setTextInput(true)
    love.keyboard.setKeyRepeat(true)
    self.super.enter(self)
    self.lastState = bishop.game.current.stack:current()
    self:_screenshot()
    self.inputHistory = {}
  end

  function instance:leave()
    love.keyboard.setTextInput(false)
    love.keyboard.setKeyRepeat(false)
    self.super.leave(self)
  end

  function instance:load()
    local this = self, font
    font = bishop.effects.font:new(self.font.name, self.font.size)
    font:load()
    self.font.data   = font.data
    self.size.height = self.font.data:getHeight() * 26
    self.size.width  = self.size.height / 0.75
    self.inputBox    = bishop.entity.text:new("", 0,
      (self.size.height / 26) * 25)
    self.historyBox  = bishop.entity.text:new("")
    self.inputBox.textColor = {255, 255, 255}
    self.historyBox.textColor = {255, 255, 255}

    self.group:add(backgroundBlock, self):add(screenshotDraw, self):
      add(self.inputBox):add(self.historyBox):add(font):
      add(bishop.effects.resize):addDefaults()

    self.line = ""
    self.super.load(self)
  end

  function instance:input(t)
    if not (t == "`" and self.line == "") then
      self.line = self.line .. t
    end
  end

  function instance:press(k, r)
    local body, func, val, status, err = nil
    if k == "`" and self.line == "" then
        bishop.game.current.stack:pop()
    elseif k == "backspace" then
      self.line = string.sub(self.line, 1, -2)
    elseif k == "up" then
      self.line = self.inputHistory[#self.inputHistory] or ""
    elseif k == "return" then
      table.insert(self.inputHistory, self.line)

      if string.sub(self.line, 1, 1) == "=" then
        self.line = "return " .. string.sub(self.line, 2)
      end

      bishop.console:current():log("> " .. self.line)

      status, func = loadstring(self.line)

      if status then
        status, val = pcall(status)
       if not status then err = val end
      else
        err = func
      end

      if err then
        self:_log("Error: " .. tostring(err))
      elseif val ~= nil then
        self:_log(tostring(val))
      end

      self.line = ""
      self.inputBox.text = "> _"
      self.historyBox.text = table.concat(self:_relevant(), "\n")
    end
  end

  function instance:resize(...)
    self.screenshot = nil
  end

  function instance:update(dt)
    self.inputBox.text = "> " .. self.line .. "_"
    self.historyBox.text = table.concat(self:_relevant(), "\n")
    self.super.update(self, dt)

    if bishop.game.current.controller:isPressed("exit") then
      bishop.game.current:exit()
    end
  end

  function instance:_relevant()
    local history = bishop.console:current().history
    local value = table.slice(history, #history - 24)
    return value
  end

  function instance:_log(string)
    local log = {}
    local result = ""

    for token in string.gmatch(string, "[^\r\n]+") do
      table.insert(log, token)
    end

    result = "] " .. table.concat(log, "\n] ")

    bishop.console:current():log(result)
  end

  function instance:_screenshot(...)
    local canvas = love.graphics.newCanvas(...)
    local imageData

    bishop.game.current.screen:encapsulate(function()
      self.lastState:update(0)
      self.lastState:draw()
    end)

    imageData = love.graphics.newScreenshot()
    love.graphics.clear()
    imageData:encode("test.png")
    self.screenshot = love.graphics.newImage(imageData)
  end
end)
