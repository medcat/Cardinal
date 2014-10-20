require "ext"
require "core"
require "game"

function love.load()
  Cardinal.Screen.current = Cardinal.Screen:new()
  Cardinal.Controller.current = Cardinal.Controller.Keyboard:new()
  Cardinal.State.push(Cardinal.Game.States.MainMenu)
  Cardinal.Screen.current:update()
  Cardinal.Console:log(Cardinal.Screen.current:output())
end

function love.update(dt)
  Cardinal.Screen.current:update()
  Cardinal.State.current():update(dt)
end

function love.textinput(t)
  Cardinal.State.current():input(t)
end

function love.keypressed(k, r)
  Cardinal.State.current():press(k, r)
end

function love.keyreleased(k)
  Cardinal.State.current():release(k, r)
end

function love.draw()
  Cardinal.Screen.current:encapsulate(function()
    Cardinal.State.current():draw()
  end)
end
