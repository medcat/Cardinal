local module = {}
define.types.module = module

function module:finalize(definition)
  local value = {}
  value._meta = {
    definition = definition,
    __index    = {
      tostring = function(self) return "#module<" .. self.name .. ">" end,
      name     = "module"
    },
    __tostring = function() return value:tostring() end
  }
  setmetatable(value, value._meta)
  value.name = definition.name
  definition.content(value)

  if not definition.anon then
    define.set(definition.name, value)
  end

  return value
end
