define "bishop.save":
as(function(class, instance)

  class.defaults        = {}
  class.defaults.config = {}
  class.defaults.save   = {}
  class.saves           = {}
  class.config          = {}

  -- just a general data loader
  function class:loadFrom(name, defaults)
    local ok, chunk, result
    ok, chunk = pcall(love.filesystem.load, self:_path(name))
    if not ok then return defaults end
    ok, result = pcall(chunk)
    if not ok then return defaults end
    return result
  end

  function class:saveTo(name, data)
    if type(data) ~= "table" then error("expected table") end
    return love.filesystem.write(self:_path(name),
      "return " .. table.tostring(data))
  end

  function class:loadSaveData()
    self.saves  = {}
    self.config = nil

    self.config = self:loadFrom("config", table.merge({}, self.defaults.config))
    -- TODO
  end

  function class:_path(name)
    return name .. ".lua"
  end

end)
