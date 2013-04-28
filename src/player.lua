player = {}

player.x = (550)/2
player.y = (640)/2
player.height = 10

player.image = love.graphics.newImage("images/character.png")
player.stand = {}

local frames = 6
local animations = 4

for i=1,6 do
	player.stand[i]=love.graphics.newQuad((i-1)*12,0,12,12,frames*12,animations*12)
end
player.standTime = 0.2

player.run = {}
for i=1,6 do
	player.run[i]=love.graphics.newQuad((i-1)*12,12,12,12,frames*12,animations*12)
end
player.runTime = 0.05

player.up = {}
for i=1,6 do
	player.up[i]=love.graphics.newQuad((i-1)*12,24,12,12,frames*12,animations*12)
end

player.down = {}
for i=1,6 do
	player.down[i]=love.graphics.newQuad((i-1)*12,36,12,12,frames*12,animations*12)
end


player.curFrame = 1


player.grounded = false

player.time = 0

player.accel = 700
player.gravity = 400
player.damp = 1
player.grounddamp = 10

player.airtime = 0

player.dx = 0
player.dy = 0

player.lastscreen = {x=0,y=0}
player.lastpos = {x=player.x,y=player.y}

function player.getScreen()
	return math.floor(player.x/192),math.floor(player.y/192)
end

function player.update(dt)
	if GLOBAL.mode=="play" then
		local sx,sx = player.getScreen()
		player.time = player.time+dt

		if player.grounded and math.abs(player.dx)<1 then
			while player.time>player.standTime do
				player.time = player.time-player.standTime
				player.curFrame = player.curFrame+1
			end
		else
			while player.time>player.runTime do
				player.time = player.time-player.runTime
				player.curFrame = player.curFrame+1
			end
		end
		if player.curFrame>frames then
			player.curFrame = 1
		end

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

		player.dy = player.dy+dt*player.gravity

		player.y = player.y+player.dy*dt
		if levelscreen.getCollision(player.x,player.y) then
			if player.dy>250 then
				player.x = player.lastpos.x
				player.y = player.lastpos.y
			end
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
		--love.graphics.setColor(0,255,0)
	else
		--love.graphics.setColor(255,0,0)
	end
	love.graphics.setColor(useful.hsv(GLOBAL.fghue,GLOBAL.fgsat,GLOBAL.fgval))
	local anim = useful.tri(math.abs(player.dx)>10,player.run,player.stand)
	local updown = useful.tri(player.dy<0,player.up,player.down)
	anim = useful.tri(player.grounded,anim,updown)
	love.graphics.drawq(player.image,
		anim[player.curFrame],
		math.floor(player.x-math.sign(player.dx)*6),
		math.floor(player.y-11),0,math.sign(player.dx),1)
	--love.graphics.draw(player.image, math.floor(player.x),math.floor(player.y),0,math.sign(player.dx),1,6,11)
	--love.graphics.rectangle("fill",math.floor(player.x)-2,math.floor(player.y)-4,4,4)
end