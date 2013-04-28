local state = gstate.new()


function state:init()
	dascween = love.graphics.newCanvas(256,256)
	dascween:setFilter("nearest","nearest")
	vig = love.graphics.newImage("images/vig.png")
	unsaved = false
	--GLOBAL.mode = "edit"
end


function state:enter()

end


function state:focus()

end


function state:mousepressed(x, y, btn)
	if GLOBAL.mode == "edit" then
		unsaved = true
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
				if btn=="l" then
					levelscreen.decorate(decoration.new(math.floor(x/2)+px*192,math.floor(y/2)+py*192, decoration.currentImage))
				elseif btn=="r" then
					decoration.currentImage = decoration.currentImage+1
					if decoration.currentImage>#decoration.images then
						decoration.currentImage=1
					end
				end
			elseif GLOBAL.currentTool==3 then
				if btn=="l" then
					hotspot.new(math.floor(x/2)+px*192,math.floor(y/2)+py*192, decoration.currentImage)
				elseif btn=="r" then
				end
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
	if key=="h" and GLOBAL.mode=="edit" then
		GLOBAL.makeColour()
		levelscreen.getGlobalHSV()
	end
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
		levelscreen.toLuaScript("level1")
		unsaved = false
	end
	if key=="backspace" and GLOBAL.mode=="edit" and GLOBAL.currentTool==2 then
		levelscreen.removeLastDeco()
	elseif key=="backspace" and GLOBAL.mode=="edit" and GLOBAL.currentTool==3 then
		table.remove(hotspot.all,#hotspot.all)
	end
	if GLOBAL.mode=="edit" then
		if key=="up" then
			player.y=player.y-192
		end
		if key=="down" then
			player.y=player.y+192
		end
		if key=="left" then
			player.x=player.x-192
		end
		if key=="right" then
			player.x=player.x+192
		end
	end
end


function state:keyreleased(key, uni)
	
end


function state:update(dt)
	levelscreen.update(dt)
	player.update(dt)
	hotspot.update(dt)
end


function state:draw()
	--love.graphics.setBackgroundColor(useful.hsv(GLOBAL.skyhue,GLOBAL.skysat,GLOBAL.skyval))
	love.graphics.setBackgroundColor(0,0,0)
	love.graphics.push()
	--love.graphics.scale(2,2)
	love.graphics.setCanvas(dascween)
	--love.graphics.setBlendMode("premultiplied")
	love.graphics.setBlendMode("alpha")
	love.graphics.setColor(useful.hsv(GLOBAL.skyhue,GLOBAL.skysat,GLOBAL.skyval))
	love.graphics.rectangle("fill",0,0,256,256)
	--------------------------------------SCALING
	local offx, offy = player.getScreen()
	love.graphics.push()
	love.graphics.translate(-offx*192,-offy*192)

	love.graphics.setColor(255,255,255)

	levelscreen.draw()
	player.draw()
	love.graphics.setColor(255,255,255)
	hotspot.draw()

	love.graphics.pop()
	if unsaved then
		love.graphics.setColor(255,0,0)
		love.graphics.rectangle("line",0,0,192,192)
	end
	------------------------------------END SCALING
	love.graphics.setCanvas()
	love.graphics.setBlendMode("premultiplied")
--	love.graphics.setBlendMode("alpha")
	love.graphics.setColor(255,255,255)
	love.graphics.draw(dascween,0,0,0,2,2)
	love.graphics.setColor(0,0,0,140)
	love.graphics.draw(vig, 0, 0,0,2,2)
	love.graphics.pop()
	if GLOBAL.mode == "edit" then
		love.graphics.setColor(255,255,255)
		love.graphics.print("Editing - "..GLOBAL.edittools[GLOBAL.currentTool],10,10)
		if GLOBAL.currentTool==2 then
			love.graphics.draw(decoration.images[decoration.currentImage],love.mouse.getX(),love.mouse.getY(),0,2,2)
		end
		love.graphics.print("H:"..math.floor(GLOBAL.hue).." S:"..(math.floor(GLOBAL.sat*100)/100).." V:"..(math.floor(GLOBAL.val*100)/100),10,360)
	end
end

return state