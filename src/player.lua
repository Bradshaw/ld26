player = {}

player.x = 96
player.y = 96

player.grounded = false

player.accel = 500
player.damp = 3
player.grounddamp = 6

player.dx = 0
player.dy = 0

function player.update(dt)
	if GLOBAL.mode=="play" then

		if love.keyboard.isDown("left","q","a") then
			player.dx = player.dx - player.accel * dt
		end
		if love.keyboard.isDown("right","d") then
			player.dx = player.dx + player.accel * dt
		end

		if	love.keyboard.isDown("up","z"," ","w") and player.grounded then
			player.dy = -300
			player.y = player.y-2
		end

		player.dx = player.dx - player.dx*player.grounddamp*dt
		player.dy = player.dy - player.dy*player.damp*dt

		player.dy = player.dy+dt*player.accel

		player.y = player.y+player.dy*dt
		if levelscreen.get(player.x,player.y).collide then
			if player.dy>0 then
				player.y = math.floor(player.y/16)*16-1
			else
				player.y = math.floor(player.y/16)*16+17
			end
			player.dy = 0
		end

		player.x = player.x+player.dx*dt
		if levelscreen.get(player.x,player.y).collide then
			if player.dx>0 then
				player.x = math.floor(player.x/16)*16-1
			else
				player.x = math.floor(player.x/16)*16+17
			end
			player.dx = -player.dx/2
		end

		player.grounded = levelscreen.get(player.x,player.y+1).collide
	end
end

function player.draw()
	love.graphics.rectangle("fill",math.floor(player.x)-2,math.floor(player.y)-4,4,4)
end