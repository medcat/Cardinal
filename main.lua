require "core"
require "bishop"
require "cardinal"

function love.load(...)
  bishop.game.current = cardinal
  cardinal:load(...)
end

function love.resize(...)
  cardinal:resize(...)
end

function love.update(...)
  cardinal:update(...)
end

function love.textinput(...)
  cardinal:input(...)
end

function love.keypressed(...)
  cardinal:press(...)
end

function love.keyreleased(...)
  cardinal:release(...)
end

function love.draw(...)
  cardinal:draw(...)
end
