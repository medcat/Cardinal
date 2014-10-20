--[[
  Used primarily for defining modules/classes.  It handles setting
  metatables and other annoying things.
]]--

--[[
  Example:

    define "bishop.entity.group": type "class": extends "bishop.entity":
    as(function(group)
      function group:test(self)
        print("Hello, world!")
      end
    end)
]]--

-- We're going to set it to be a table, so we can access properties on
-- it.
define = {}

local function defineCall(self, _)
  local name = _ or self
  local definition = {}

  setmetatable(definition, { __index = define.definition })

  definition.name = name
  return definition
end

function define.anon(self, _)
  local name = _ or self
  local definition = {}

  setmetatable(definition, { __index = define.definition })

  definition.name = name
  definition.anon = true
  return definition
end

function define.module(self, name, func)
  if type(self) == 'string' then
    func = name
    name = self
  end

  return define(name):type("module"):as(func or function() end)
end

setmetatable(define, { __call = defineCall })

-- Given a path, such as "a.b.c.d", gets the value of the "d" key on
-- the table "a.b.c".
function define.get(path)
  local v = _G

  for w in string.gfind(path, "[%w_]+") do
    v = v[w]
  end

  return v
end


-- Given a path, such as "a.b.c.d", sets the value of the "d" key on
-- the table "a.b.c".
function define.set(path, value)
  local top = _G

  for w, d in string.gfind(path, "([%w_]+)(.?)") do
    if d == '.' then -- we're not in the last field
      if top[w] == nil then
        print("WARN: top[\"" .. w .. "\"] has a nil value!")
        top[w] = {}
      end

      top = top[w]
    else
      top[w] = value
    end
  end

  return value
end

-----------------------
-- A definition instance.  This is returned by defineCall.
define.definition = {
  _type = "class",
  name  = "<anon>",
  anon  = false
}

function define.definition:type(newType)
  self._type = newType
  return self
end

function define.definition:extends(extension)
  if type(extension) == "string" then
    extension = define.get(extension)
  end

  self.extension = extension
  return self
end

function define.definition:as(content)
  self.content = content
  return define.types[self._type]:finalize(self)
end

---------------------
-- The types within the define group.
define.types = {}

require "core.define.class"
require "core.define.module"
require "core.define.instance"
