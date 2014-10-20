define "bishop.console":
as(function(class, instance)
  instance.history = {}
  instance.limit   = 24
  function instance:log(part)
    local value

    value = tostring(part)

    for token in string.gmatch(value, "[^\r\n]+") do
      print(token)
      table.insert(self.history, token)
    end

    if #self.history > self.limit then
      self.history = { unpack(self.history, #self.history - self.limit, #self.history) }
    end
  end

  function class:log(part)
    bishop.game.current.console:log(part)
  end

end)
