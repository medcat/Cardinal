bishop.asset = class("bishop.asset"):
  extends(bishop.entity)
{
  variants = nil,
  variantKey = nil,

  initialize = function(self)
    self.variantKey = "default"
    self.variants = {}
    self.super.initialize(self)
  end,

  variant = function(self)
    return self.variants[self.variantKey]
  end,

  --[[
  Forward all of our Entity functions to the variant.
  ]]--
  load = function(self)
    return self:variant():load()
  end,

  update = function(self, dt)
    return self:variant():update(dt)
  end,

  draw = function(self)
    return self:variant():draw()
  end,

  keypress = function(self, key)
    return self:variant():keypress(key)
  end,

  keyrelease = function(self, key)
    return self:variant():keyrelease(key)
  end
}

require "bishop.asset.variant"
require "bishop.asset.image"
