Cardinal.Entity.Group = class("Cardinal.Entity.Group") : extends(Cardinal.Entity)
{
  parts = nil,
  effects = nil,

  initialize = function(self)
    self.parts = {}
    self.effects = {}
    self._loaded = false
    self.super.initialize(self)
  end,

  add = function(self, entity, ...)
    local part

    if type(entity) == "function" then
      part = class("<anon>.group/function"):
        extends(Cardinal.Entity)({draw=entity}):new()
    elseif entity.new then
      part = entity:new(...)
    elseif entity.isA and (entity:isA(Cardinal.Entity) or
      entity:isA(Cardinal.Effect)) then
      part = entity
    else
      part = class("<anon>.group/table"):
        extends(Cardinal.Entity)(entity):new()
    end

    if part:isA(Cardinal.Entity) then
      Cardinal.Console:log("[group] adding entity " .. tostring(part))
      table.insert(self.parts, part)
    elseif part:isA(Cardinal.Effect) then
      Cardinal.Console:log("[group] adding effect " .. tostring(part))
      table.insert(self.effects, part)
    end

    if self._loaded and part then
      part:load()
    end

    return self
  end,

  addDefaults = function(self)
    self:add(Cardinal.Game.Effects.Reset:new())
    --self:add(Cardinal.Game.Effects.Resize:new(Cardinal.Screen.current))
    return self
  end,

  remove = function(self, entity)
    if entity:isA(Cardinal.Entity) then
      for k, v in ipairs(self.parts) do
        if v == entity then
          self.parts[k] = nil
        end
      end
    elseif entity:isA(Cardinal.Effect) then
      for k, v in ipairs(self.effects) do
        if v == entity then
          self.effects[k] = nil
        end
      end
    else
      error("Unknown entity given to Group: " .. entity.class.name)
    end

    return self
  end,

  _presortParts = function(self)
    table.sort(self.parts, function(first, second)
      return first.zindex < second.zindex
    end)
  end,

  load = function(self)
    self:_presortParts()

    for k, v in ipairs(self.parts) do
      v:load()
    end

    for k, v in ipairs(self.effects) do
      v:load()
    end

    self._loaded = true
    return self
  end,

  update = function(self, dt)
    self:_presortParts()

    for k, v in ipairs(self.parts) do
      v:update(dt)
    end

    return self
  end,

  draw = function(self)
    self:_presortParts()

    for k, v in ipairs(self.effects) do
      v:beforeAll()
    end

    for k, v in ipairs(self.parts) do
      for i, w in ipairs(self.effects) do w:beforeEach() end
      v:draw()
      for i, w in ipairs(self.effects) do w:afterEach() end
    end

    for k, v in ipairs(self.effects) do
      v:afterAll()
    end

    return self
  end
}
