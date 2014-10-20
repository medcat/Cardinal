Cardinal.Console = {
  history = {},
  log = function(self, part)
    local value
    if #self.history > self.limit then
      self.history = { unpack(self.history, #self.history - self.limit, #self.history) }
    end

    value = tostring(part)

    print(value)
    table.insert(self.history, value)
  end,
  limit = 23,
}
