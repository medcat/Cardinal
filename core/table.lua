local function valtostr(v, stack)
  if type(v) == "string" then
    v = string.gsub(v, "\n", "\\n")
    if string.match(string.gsub(v,"[^'\"]",""), '^"+$') then
      return "'" .. v .. "'"
    end
    return '"' .. string.gsub(v, '"', '\\"') .. '"'
  else
    return type(v) == "table" and table.tostring(v, stack + 1) or
      tostring(v)
  end
end

local function keytostr(k)
  if type(k) == "string" and string.match(k, "^[_%a][_%a%d]*$") then
    return k
  else
    return "[" .. table.valtostr(k, stack + 1) .. "]"
  end
end

function table.tostring(tbl, stack)
  local result, done = {}, {}
  local mt, key, indent, value
  stack = stack or 0

  if stack > 3 then
    return "{...}"
  end

  for k, v in ipairs(tbl) do
    table.insert(result, valtostr(v, stack + 1))
    done[ k ] = true
  end
  for k, v in pairs(tbl) do
    if not done[k] then
      key = keytostr(k, stack + 1)

      if key and string.sub(key, 1, 1) ~= "_" then
        table.insert(result,
          key .. " = " .. valtostr(v, stack + 1))
      end
    end
  end

  indent = string.rep(" ", stack + 1)
  value = table.concat(result, ",\n" .. indent)
  return "{\n" .. indent .. value .. "}"
end
