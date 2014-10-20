bishop.console = {
  history = {},
  log = function(self, part)
    local value

    value = tostring(part)

    for token in string.gmatch(value, "[^\r\n]+") do
      print(token)
      table.insert(self.history, token)
    end

    if #self.history > self.limit then
      self.history = { unpack(self.history, #self.history - self.limit, #self.history) }
    end
  end,
  limit = 24,
}
