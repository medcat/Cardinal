define "cardinal.character.attributes.list": type "module":
as(function(module)

  local attribute = cardinal.character.attribute
  local data = require "cardinal.character.attributes.data"
  local attr

  for i, v in ipairs(data) do
    attr = attribute:new(v)
    module[attr.name] = attr
  end
end)
