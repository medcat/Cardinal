define "bishop.console": type "module":
as(function(console)
  console.history = {}
  console.limit   = 24
  function console:log(part)
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

end)
