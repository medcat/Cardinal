--[[
  Defines a class.  It returns a callable object, which should
  be called with a table as its first argument; that will then
  return a class object.
]]--
function class(name)
  local klassable = {__instance={},super=Class,name=name}

  setmetatable(klassable, {__call=function(self, definition)
    klassable.__instance = definition or self

    klassable.__instance.super = {}
    klassable.__instance.class = klassable
    klassable.extends = nil
    setmetatable(klassable,
      {__index=klassable.super,
        __tostring=function() return klassable:toString() end})
    setmetatable(klassable.__instance,
      {__index=klassable.super.__instance})
    setmetatable(klassable.__instance.super,
      {__index=klassable.super.__instance,
        __tostring=function() return "#<" .. name .. "/super>" end })
    return klassable
  end})

  function klassable:extends(super)
    assert(super and super.__instance)
    self.super = super
    return self
  end

  return klassable
end

--[[
  Defines the super of all of the classes.
]]--
Class =
{
  new = function(self, ...)
    local instance = {}
    setmetatable(instance, {__index=self.__instance,
      __tostring=function() return instance:toString() end})
    if instance.initialize then
      instance:initialize(...)
    end
    return instance
  end,

  name = "Class",

  hasParent = function(self, check)
    assert(self and check, "Nil passed to hasParent")

    if self == check then
      return true
    end

    if self == Class then
      return false
    end

    return self.super:hasParent(check)
  end,

  toString = function(self)
    return self.name
  end,

  __instance =
  {
    initialize = function() end,
    isA = function(self, check)
      assert(self and check, "Nil passed to isA")
      return self.class:hasParent(check)
    end,
    toString = function(self)
      return "#<" .. tostring(self.class) .. ">"
    end,
  },
}
