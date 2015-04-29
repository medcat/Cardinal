local class, mainClass
class = {}
define.types.class = class

function class:finalize(definition)
  local def, klass, instance
  def = {
    __definition = definition,
    class = {
      __super = definition.extension or mainClass,
      super   = {},
      name    = definition.name
    },
    instance = {
      class   = klass
    }
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
      return klass:tostring()
    end
  })
  setmetatable(instance, { __index = instance.__super })

  setmetatable(klass.super, {
    __index = klass.__super,
    __newindex = function(_, k, v)
      error("Attempted assignment on super table!", 2)
    end,
    __tostring = function()
      return klass.__super:tostring()
    end,
  })

  definition.content(klass, instance)

  klass.__def = def

  if not definition.anon then
    define.set(definition.name, klass)
  end

  return klass
end

mainClass = {
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
      __tostring = function() return instance:tostring() end
    })

    if instance.initialize then
      instance:initialize(...)
    end

    return instance
  end,

  name = "class",
  tostring = function(self)
    return "#class<" .. self.name .. ">"
  end,

  hasparent = function(self, check)
    assert(self and check, "Nil passed to hasParent")

    if self.__def == check.__def then
      return true
    end

    if self.__def == mainClass.__def then
      return false
    end

    return self.super:hasparent(check)
  end,

  __instance = {
    initialize = function() end,
    isa = function(self, check)
      assert(self and check, "Nil passed to isA")
      return self.class:hasparent(check)
    end,
    tostring = function(self)
      return "#instance<" .. self.class.name .. ">"
    end,
  }

}
