define "bishop.effects.reset": extends "bishop.effect":
as(function(class, instance)
  instance.options = {}

  --[[
    Creates a reset effect that resets all of the graphical options
    back to the originals.  The options include:

    - `context`
    - `color` (including `color` and `backgroundColor`)
    - `canvas`
    - `shader`
    - `scissor`
    - `blend`
    - `mask`
    - `wireframe`
    - `line`
    - `point`

    The only option not included in the `all` option is `scissor`.
    The reason being that bishop usses scissor internally.
    Individual options can be excluded from `all` by setting their
    values to false.

    bishop.effects.reset:new { all = true, wireframe = false }
  ]]

  function instance:initialize(options)
    self.options = options or { all = true }
  end

  function instance:beforeEach()
    if self:_isAffected("context") then
      love.graphics.push()
    end
  end

  function instance:afterEach()
    if self:_isAffected("context") then
      love.graphics.pop()
    end

    if self:_isAffected("color") then
      love.graphics.setColor(255, 255, 255, 255)
      love.graphics.setBackgroundColor(0, 0, 0, 255)
    end

    if self:_isAffected("canvas") then
      love.graphics.setCanvas()
    end

    if self:_isAffected("shader") then
      love.graphics.setShader()
    end

    if self:_isAffected("scissor", false) then
      love.graphics.setScissor()
    end

    if self:_isAffected("blend") then
      love.graphics.setBlendMode("alpha")
    end

    if self:_isAffected("mask") then
      love.graphics.setColorMask()
    end

    if self:_isAffected("wireframe") then
      love.graphics.setWireframe(false)
    end

    if self:_isAffected("line") then
      love.graphics.setLineWidth(1.0)
    end

    if self:_isAffected("point") then
      love.graphics.setPointSize(1.0)
    end
  end

  function instance:_isAffected(name, includesAll)
    if type(includesAll) == "nil" then
      includesAll = true
    end

    return self.options[name] or
           (self.options[name] ~= false and
            self.options["all"] and
            includesAll)
  end
end)
