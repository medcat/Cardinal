define "bishop.entity.group": extends "bishop.entity":
as(function(class, instance)

  instance.parts = nil
  instance.effects = nil

  function instance:initialize()
    self.parts = {}
    self.effects = {}
    self._loaded = false
    self.super.initialize(self)
  end

  function instance:add(entity, ...)
    local part

    if type(entity) == "function" then
      --part = class("<anon>.group/function"):
      --  extends(bishop.entity)({draw=entity}):new()
      part = define.anon("<anon>.group.function"):
        extends("bishop.entity"):
        as(entity):new()
    elseif entity.new then
      part = entity:new(...)
    elseif entity.isA and (entity:isA(bishop.entity) or
      entity:isA(bishop.effect)) then
      part = entity
    else
      error("Unknown entity type!")
    end

    if part:isA(bishop.entity) then
      bishop.console:log("[group] adding entity " .. tostring(part))
      table.insert(self.parts, part)
    elseif part:isA(bishop.effect) then
      bishop.console:log("[group] adding effect " .. tostring(part))
      table.insert(self.effects, part)
    end

    if self._loaded and part then
      part:load()
    end

    return self
  end

  function instance:addDefaults()
    self:add(cardinal.effects.reset:new())
    return self
  end

  function instance:remove(entity)
    if entity:isA(bishop.entity) then
      for k, v in ipairs(self.parts) do
        if v == entity then
          self.parts[k] = nil
        end
      end
    elseif entity:isA(bishop.effect) then
      for k, v in ipairs(self.effects) do
        if v == entity then
          self.effects[k] = nil
        end
      end
    else
      error("Unknown entity given to Group: " .. entity.class.name)
    end

    return self
  end

  function instance:_presortParts()
    table.sort(self.parts, function(first, second)
      return first.zindex < second.zindex
    end)
  end

  function instance:load()
    self:_presortParts()

    for k, v in ipairs(self.parts) do
      v:load()
    end

    for k, v in ipairs(self.effects) do
      v:load()
    end

    self._loaded = true
    return self
  end

  function instance:update(dt)
    self:_presortParts()

    for k, v in ipairs(self.parts) do
      v:update(dt)
    end

    return self
  end

  function instance:draw()
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
end)
