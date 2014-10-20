local module = {}
define.types.module = module

function module:finalize(definition)
  local value = {}

  setmetatable(value, {
    definition = definition,
    __index    = module,
    __tostring = function() return value:tostring() end
  })
  value.name = definition.name
  definition.content(value)

  if not definition.anon then
    define.set(definition.name, value)
  end

  return value
end

module = {
  tostring = function(self)
    return "#module<" .. self.name .. ">"
  end,

  name = "module"
}
