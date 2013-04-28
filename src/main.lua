function love.load(arg)
	love.graphics.setDefaultImageFilter("nearest","nearest")
	require("sparkle")
	require("global")
	require("useful")
	gstate = require "gamestate"
	game = require("game")
	require("hotspot")
	require("levelscreen")
	require("tile")
	require("player")
	require("decoration")
	snd = {}
	snd.prayed = love.audio.newSource("audio/Prayed.ogg")
	snd.intro = love.audio.newSource("audio/Intro.ogg")
	snd.intro2 = love.audio.newSource("audio/Intro2.ogg")
	snd.nopain = love.audio.newSource("audio/NoPainNoGain.ogg")
	snd.thesoul = love.audio.newSource("audio/TheSoul.ogg")
	snd.wind1 = love.audio.newSource("audio/Wind1.ogg")
	snd.wind2 = love.audio.newSource("audio/Wind2.ogg")
	snd.step = love.audio.newSource("audio/Step.ogg")
	snd.intro2:setLooping(true)
	snd.step:setVolume(0)
	snd.wind1:setLooping(true)
	snd.wind1:play()
	snd.wind2:setLooping(true)
	snd.wind2:play()
	snd.intro:setLooping(true)
	snd.intro:setVolume(0.5)
	snd.intro:play()
	snd.thesoul:setVolume(0.5)
	snd.thesoul:play()

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
