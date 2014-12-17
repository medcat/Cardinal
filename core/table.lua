local function valtostr(v)
  if type(v) == "string" then
    v = string.gsub(v, "\n", "\\n")
    if string.match(string.gsub(v,"[^'\"]",""), '^"+$') then
      return "'" .. v .. "'"
    end
    return '"' .. string.gsub(v, '"', '\\"') .. '"'
  else
    return type(v) == "table" and table.tostring(v) or
      tostring(v)
  end
end

local function keytostr(k)
  if type(k) == "string" and string.match(k, "^[_%a][_%a%d]*$") then
    return k
  else
    return "[" .. valtostr(k) .. "]"
  end
end

function table.tostring(tbl)
  local result, done = {}, {}
  for k, v in ipairs(tbl) do
    table.insert(result, valtostr(v))
    done[ k ] = true
  end
  for k, v in pairs(tbl) do
    if not done[k] then
      table.insert(result, keytostr(k) .. "=" .. valtostr(v))
    end
  end
  return "{" .. table.concat(result, ",") .. "}"
end
