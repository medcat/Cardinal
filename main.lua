Cardinal = { Game = { } }

require "ext.serialize"
require "core.class"
require "core.drawable"
require "core.screen"
require "core.effect"
require "core.entity"
require "core.asset"
require "core.state"
require "core.controller"
require "core.map"
require "game.assets"
require "game.effects"
require "game.states"
require "game.maps"

function love.load()
  Cardinal.Screen.current = Cardinal.Screen:new()
  Cardinal.Controller.current = Cardinal.Controller.Keyboard:new()
  Cardinal.State.transitionTo(Cardinal.Game.States.MainMenu)
  Cardinal.Screen.current:update()
  print(Cardinal.Screen.current:output())
end

function love.update(dt)
  Cardinal.Screen.current:update()
  Cardinal.State.current:update(dt)
end

function love.textinput(t)
  Cardinal.State.current:input(t)
end

function love.keypressed(k, r)
  Cardinal.State.current:press(k, r)
end

function love.keyreleased(k)
  Cardinal.State.current:release(k, r)
end

function love.draw()
  Cardinal.Screen.current:encapsulate(function()
    Cardinal.State.current:draw()
  end)
end
