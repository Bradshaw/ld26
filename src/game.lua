local state = gstate.new()


function state:init()
	GLOBAL.mode = "edit"
end


function state:enter()

end


function state:focus()

end


function state:mousepressed(x, y, btn)
	if GLOBAL.mode == "edit" then
		levelscreen.tweak(math.floor(x/32)+1,math.floor(y/32)+1)
	end
end


function state:mousereleased(x, y, btn)
	
end


function state:joystickpressed(joystick, button)
	
end


function state:joystickreleased(joystick, button)
	
end


function state:quit()
	
end


function state:keypressed(key, uni)
	if key=="escape" then
		love.event.push("quit")
	end
	if key=="return" then
		if GLOBAL.mode == "edit" then
			GLOBAL.mode = "play"
		else
			GLOBAL.mode = "edit"
		end
	end
end


function state:keyreleased(key, uni)
	
end


function state:update(dt)
	levelscreen.update(dt)
	player.update(dt)
end


function state:draw()
	love.graphics.push()
	love.graphics.scale(2,2)
	--------------------------------------SCALING


	levelscreen.draw()
	player.draw()


	------------------------------------END SCALING
	love.graphics.pop()
end

return state