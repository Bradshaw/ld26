player = {}

player.x = (576)/2
player.y = (576)/2
player.height = 10

player.grounded = false

player.accel = 500
player.damp = 1
player.grounddamp = 6

player.airtime = 0

player.dx = 0
player.dy = 0

function player.getScreen()
	return math.floor(player.x/192),math.floor(player.y/192)
end

function player.update(dt)
	if GLOBAL.mode=="play" then

		if love.keyboard.isDown("left","q","a") then
			player.dx = player.dx - player.accel * dt
		end
		if love.keyboard.isDown("right","d") then
			player.dx = player.dx + player.accel * dt
		end

		if	love.keyboard.isDown("up","z"," ","w") and player.grounded then
			player.dy = -200
			player.y = player.y-3
			player.grounded = false
		end
		if not grounded then
			player.airtime = player.airtime+dt
		else
			player.airtime = 0
		end

		player.dx = player.dx - player.dx*player.grounddamp*dt
		player.dy = player.dy - player.dy*player.damp*dt

		player.dy = player.dy+dt*player.accel

		player.y = player.y+player.dy*dt
		if levelscreen.getCollision(player.x,player.y) then
			local _, cx, cy, slope = levelscreen.getCollision(player.x,player.y)
			if slope then
				if player.dy>0 then
					player.y = cy-1
				else
					player.y = cy+1
				end
			else
				if player.dy>0 then
					player.y = math.floor(player.y/16)*16-1
				else
					player.y = math.floor(player.y/16)*16+17
				end
			end
			player.dy = 0
		end
		local _,_,_,beforeslope = levelscreen.getCollision(player.x,player.y)
		player.x = player.x+player.dx*dt
		local _, cx, cy, slope = levelscreen.getCollision(player.x,player.y)
		if slope and player.grounded then
			player.y = cy
		end
		if levelscreen.getCollision(player.x,player.y) then
			local _, cx, cy, slope = levelscreen.getCollision(player.x,player.y)
			if (slope or beforeslope) and math.abs(cy-player.y)<2 then
				if player.dx>0 then
					--player.x = math.floor(player.x/16)*16
				else
					--player.x = math.floor(player.x/16)*16+16
				end
				--player.dx = -player.dx/2
				player.y = cy
				player.dy =0
			else
				if player.dx>0 then
					player.x = math.floor(player.x/16)*16-1
				else
					player.x = math.floor(player.x/16)*16+17
				end
				player.dx = -player.dx/2
			end
		end
		if player.grounded and levelscreen.getCollision(player.x,player.y+2) then
			while not levelscreen.getCollision(player.x,player.y+1) do
				player.y = player.y+0.1
			end
		end
		player.grounded = levelscreen.getCollision(player.x,player.y+1)
	end
end

function player.draw()
	if player.grounded then
		love.graphics.setColor(0,255,0)
	else
		love.graphics.setColor(255,0,0)
	end
	love.graphics.rectangle("fill",math.floor(player.x)-2,math.floor(player.y)-4,4,4)
end