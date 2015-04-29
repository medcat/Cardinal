define "bishop.console":
as(function(class, instance)
  instance.history = {}
  instance.limit   = 24000
  function instance:log(part)
    local value

    value = tostring(part)

    for token in string.gmatch(value, "[^\r\n]+") do
      table.insert(self.history, token)
    end

    if #self.history > self.limit then
      self.history = { unpack(self.history, #self.history - self.limit, #self.history) }
    end
  end

  function class:log(part)
    return class:current():log(part)
  end

  function class:current()
    return bishop.game.current.console
  end

end)
