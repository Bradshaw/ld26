function love.load(arg)
	love.graphics.setDefaultImageFilter("nearest","nearest")
	require("global")
	require("useful")
	gstate = require "gamestate"
	game = require("game")
	require("hotspot")
	require("levelscreen")
	require("tile")
	require("player")
	require("decoration")
	gstate.switch(game)
end


function love.focus(f)
	gstate.focus(f)
end

function love.mousepressed(x, y, btn)
	gstate.mousepressed(x, y, btn)
end

function love.mousereleased(x, y, btn)
	gstate.mousereleased(x, y, btn)
end

function love.joystickpressed(joystick, button)
	gstate.joystickpressed(joystick, button)
end

function love.joystickreleased(joystick, button)
	gstate.joystickreleased(joystick, button)
end

function love.quit()
	gstate.quit()
end

function love.keypressed(key, uni)
	gstate.keypressed(key, uni)
end

function keyreleased(key, uni)
	gstate.keyreleased(key)
end

max_dt = 1/30

function love.update(dt)
	gstate.update(math.min(dt,max_dt))
end

function love.draw()
	gstate.draw()
end
