function math.angle(x1, y1, x2, y2)
  return math.atan2(y2 - y1, x2 - x1)
end

function math.cerp(a, b, t)
  local f = (1 - math.cos(t * math.pi)) * .5
  return a * (1 - f) + b * f
end

function math.clamp(low, number, high)
  return math.min(math.max(low, number), high)
end

function math.dist(x1, y1, x2, y2)
  return ((x2 - x1)^2 + (y2 - y1)^2)^0.5
end

function math.dist3(x1, y1, z1, x2, y2, z2)
  return ((x2 - x1)^2 + (y2 - y1)^2 + (z2 - z1)^2)^0.5
end

function math.lerp(a, b, t)
  return a + (b - a) * t
end

function math.multiple(number, size)
  size = size or 10

  return math.round(n / size) * size
end

function math.normalize(x, y)
  local l = (x * x + y * y)^0.5

  if l == 0 then
    return 0, 0, 0
  else
    return x / l, y / l, l
  end
end

function math.prandom(min, max)
  return math.random() * (max - min) + min
end

function math.sign(number)
  return n > 0 and 1 or n < 0 and -1 or 0
end

function math.srandom(number)
  return math.random(2) == 2 and 1 or -1
end
