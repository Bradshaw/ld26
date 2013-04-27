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
		local px,py = player.getScreen()
		if btn=="wu" or btn=="wd" then
			if btn=="wu" then
				GLOBAL.currentTool = GLOBAL.currentTool+1
				if GLOBAL.currentTool>#GLOBAL.edittools then
					GLOBAL.currentTool=1
				end
			else
				GLOBAL.currentTool = GLOBAL.currentTool-1
				if GLOBAL.currentTool<1 then
					GLOBAL.currentTool=#GLOBAL.edittools
				end
			end
			if GLOBAL.currentTool == 2 then
				love.mouse.setVisible(false)
			else
				love.mouse.setVisible(true)
			end
		else
			if GLOBAL.currentTool==1 then
				levelscreen.tweak(math.floor(x/2)+px*192,math.floor(y/2)+py*192, useful.tri(btn=="l",1,-1) )
			elseif GLOBAL.currentTool==2 then
				levelscreen.decorate(decoration.new(math.floor(x/2)+px*192,math.floor(y/2)+py*192, decoration.currentImage))
			elseif GLOBAL.currentTool==3 then

			end
		end
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
	if key=="i" then
		levelscreen.toImageData("level1.png")
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
	love.graphics.push()
	love.graphics.translate(-offx*192,-offy*192)

	love.graphics.setColor(255,255,255)

	levelscreen.draw()
	player.draw()

	love.graphics.pop()
	love.graphics.setColor(0,0,0)
	love.graphics.draw(vig, 0, 0)
	------------------------------------END SCALING
	love.graphics.pop()
	if GLOBAL.mode == "edit" then
		love.graphics.setColor(255,255,255)
		love.graphics.print("Editing - "..GLOBAL.edittools[GLOBAL.currentTool],10,10)
		if GLOBAL.currentTool==2 then
			love.graphics.draw(decoration.images[decoration.currentImage],love.mouse.getX(),love.mouse.getY(),0,2,2)
		end
	end
end

return state