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
  local deifnition = {}

  setmetatable(definition, { __index = define.definition })

  definition.name = name
  definition.anon = true
  return definition
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
  anon  = true
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
  print(self._type)
  return define.types[self._type]:finalize(self)
end

---------------------
-- The types within the define group.

local class
local classType = {}
local moduleType = {}
define.types = { class = classType, module = moduleType }

function classType:finalize(definition)
  local def, klass, instance
  def = {
    __definition = definition,
    class = {
      __super = definition.extension or class,
      super   = {},
      name    = definition.name
    },
    instance = {}
  }

  klass = def.class
  instance = def.instance
  klass.__instance = instance

  instance.class = klass
  instance.__super = klass.__super.__instance

  -- Handles the basic lookup of values that aren't on the current
  -- instance to the next super instance.
  setmetatable(klass, {
    __index = klass.__super,
    __tostring = function()
      return klass:toString()
    end
  })
  setmetatable(instance, { __index = instance.__super })

  setmetatable(klass.super, {
    __index = klass.__super,
    __newindex = function(_, k, v)
      error("Attempted assignment on super table!", 2)
    end,
    __tostring = function()
      return klass.__super:toString()
    end,
  })

  definition.content(klass, instance)

  klass.__def = def

  if not definition.anon then
    define.set(definition.name, klass)
  end

  return klass
end

function moduleType:finalize(definition)
  local value = {}

  setmetatable(value, { definition = definition })
  definition.content(value)

  if not definition.anon then
    define.set(definition.name, value)
  end

  return value
end

class = {
  new = function(self, ...)
    local instance = {}
    instance.super = {}

    setmetatable(instance.super, {
      __index = self.__instance.__super,
      __newindex = function(_, k, v)
        error("Attempted assignment on super table!", 2)
      end,
    })

    setmetatable(instance, {
      __index = self.__instance,
      __tostring = function() return instance:toString() end
    })

    if instance.initialize then
      instance:initialize(...)
    end

    return instance
  end,

  name = "class",
  toString = function(self)
    return self.name
  end,

  hasParent = function(self, check)
    assert(self and check, "Nil passed to hasParent")

    if self == check then
      return true
    end

    if self.name == class.name then
      return false
    end

    print(self)
    return self.super:hasParent(check)
  end,

  __instance = {
    initialize = function() end,
    isA = function(self, check)
      assert(self and check, "Nil passed to isA")
      return self.class:hasParent(check)
    end,
    toString = function(self)
      return "#<" .. tostring(self.class) .. ">"
    end,
  }

}
