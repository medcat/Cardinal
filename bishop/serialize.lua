define "bishop.serialize":
as(function(class, instance)

  function class:perform(object)
    return self:new(object):perform()
  end

  function instance:initialize(object)
    self.object = object
  end

  function instance:perform()
    return self:serialize(self.object)
  end

  function instance:_serialize(part)
    local temp, parttype
    parttype = type(part)

    if parttype == 'nil' then
      return "nil"
    elseif parttype == 'boolean' then
      return part and 'true' or 'false'
    elseif parttype == 'number' then
      return tostring(part)
    elseif parttype == 'function' then
      return class.cfuncs[part] or
        string.format("loadstring(%q)", string.dump(part))
    elseif parttype == 'string' then
      return string.format("%q", part)
    elseif parttype == 'table' and part.serialize then
      temp = part:serialize()
      return self:serialize(temp)
    elseif parttype == 'table' then
      return self:_serializetable(part)
    else
      error("Unknown type for " .. parttype .. " ("
        .. tostring(parttype) .. ")")
    end
  end

  function instance:_serializekey(key)
    if type(key) == 'string' and
      string.match(key, "^[_%a][_%a%d]*$") then
      return key
    else
      return "[" .. self:serialize(key) .. "]"
    end
  end


  function instance:_serializetable(value)
    local contents, result, done = nil, {}, {}

    for i, v in ipairs(value) do
      table.insert(result, self:serialize(v))
      done[i] = true
    end

    for k, v in pairs(value) do
      if not done[k] then
        table.insert(result, self:_serializekey(k) ..
          "=" .. self:serialize(v))
        done[k] = true
      end
    end

    contents = table.concat(result, ",\n")
    string.split(contents, "\n")

    return "{" .. table.concat(string.split(contents, "\n"), "\n  ") .. "}"
  end

  local function cfuncs()
    local areas = { "string", "table", "math", "io", "os", "coroutine", "package", "debug" }
    local cfuncs = {}

    for i, v in ipairs(areas) do
      local t = _G[v]
      v = v .. "."
      for k2, v2 in pairs(t) do
        if type(v2) == "function" and not pcall(string.dump, v2) then
          cfuncs[v2] = v .. k2
        end
      end
    end

    return cfuncs
  end

  class.cfuncs = cfuncs()
end)
