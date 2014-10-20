Cardinal.Game.Effects.Reset = class("Cardinal.Game.Effects.Reset"):
  extends(Cardinal.Effect)
{
  options = {},

  initialize = function(self, options)
    options = options or {"all"}
    for i, v in ipairs(options) do
      self.options[v] = true
    end
  end,

  beforeEach = function(self)
    if self.options.context or self.options.all then
      love.graphics.push()
    end
  end,

  afterEach = function(self)
    if self.options.context or self.options.all then
      love.graphics.pop()
    end

    if self.options.color or self.options.all then
      love.graphics.setColor(255, 255, 255, 255)
      love.graphics.setBackgroundColor(0, 0, 0, 255)
    end

    if self.options.canvas or self.options.all then
      love.graphics.setCanvas()
    end

    if self.options.shader or self.options.all then
      love.graphics.setShader()
    end

    if self.options.scissor then
      --love.graphics.setScissor()
    end

    if self.options.blend or self.options.all then
      love.graphics.setBlendMode("alpha")
    end

    if self.options.mask or self.options.all then
      love.graphics.setColorMask()
    end

    if self.options.wireframe or self.options.all then
      love.graphics.setWireframe(false)
    end

    if self.options.line or self.options.all then
      love.graphics.setLineWidth(1.0)
      love.graphics.setLineStyle("smooth")
    end

    if self.options.point or self.options.all then
      love.graphics.setPointSize(1.0)
      love.graphics.setPointStyle("smooth")
    end
  end
}
