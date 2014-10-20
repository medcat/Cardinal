require "ext"
require "bishop"
require "cardinal"

function love.load()
  bishop.screen.current = bishop.screen:new()
  bishop.controller.current = bishop.controller.keyboard:new()
  bishop.state.push(cardinal.states.mainMenu)
  bishop.screen.current:update()
  bishop.console:log(bishop.screen.current:output())
end

function love.update(dt)
  bishop.screen.current:update()
  bishop.state.current():update(dt)
end

function love.textinput(t)
  bishop.state.current():input(t)
end

function love.keypressed(k, r)
  bishop.state.current():press(k, r)
end

function love.keyreleased(k)
  bishop.state.current():release(k, r)
end

function love.draw()
  bishop.screen.current:encapsulate(function()
    bishop.state.current():draw()
  end)
end
