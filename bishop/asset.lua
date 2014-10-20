define "bishop.asset": extends "bishop.entity":
as(function(class, instance)
  instance.variants = nil
  instance.variantKey = nil

  function instance:initialize()
    self.variantKey = "default"
    self.variants = {}
    self.super.initialize(self)
  end

  function instance:variant()
    return self.variants[self.variantKey]
  end

  --[[
  Forward all of our Entity functions to the variant.
  ]]--
  function instance:load()
    return self:variant():load()
  end

  function instance:update(dt)
    return self:variant():update(dt)
  end

  function instance:draw()
    return self:variant():draw()
  end

  function instance:keypress(key)
    return self:variant():keypress(key)
  end

  function instance:keyrelease(key)
    return self:variant():keyrelease(key)
  end
end)

require "bishop.asset.variant"
require "bishop.asset.image"
