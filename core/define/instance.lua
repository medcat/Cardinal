local instance = {}
define.types.instance = instance

function instance:finalize(definition)
  local value = definition.extension:new(unpack(definition.content))

  if not definition.anon then
    define.set(definition.name, value)
  end

  return value
end
