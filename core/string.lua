function string:split(delimiter)
  local result, start, from, to

  result = {}
  start = 1
  from, to = string.find(self, delimiter, start, true)

  while from do
    table.insert(result, string.sub(self, start, from - 1))
    start = to + 1
    from, to = string.find(self, delimiter, start, true)
  end

  table.insert(result, string.sub(self, start))
  return result
end
