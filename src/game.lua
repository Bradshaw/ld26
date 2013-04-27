local state = gstate.new()


function state:init()
	vig = love.graphics.newImage("images/vig.png")
	GLOBAL.mode = "edit"
end


function state:enter()

end


function state:focus()

end


function state:mousepressed(x, y, btn)
	if GLOBAL.mode == "edit" then
		print(btn)
		local px,py = player.getScreen()
		levelscreen.tweak(math.floor(x/2)+px*192,math.floor(y/2)+py*192, useful.tri(btn=="l",1,-1) )
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
	local offx, offy = player.getScreen()
	love.graphics.translate(-offx*192,-offy*192)

	love.graphics.setColor(255,255,255)

	levelscreen.draw()
	player.draw()

	love.graphics.setColor(0,0,0)
	love.graphics.draw(vig)
	------------------------------------END SCALING
	love.graphics.pop()
end

return state