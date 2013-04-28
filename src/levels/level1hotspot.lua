local saveDist = 20
local prayDist = 20


function savePoint(hs,dt)
	local dx = hs.x - player.x
	local dy = hs.y - player.y
	if (dx*dx+dy*dy)<saveDist*saveDist then
		player.lastpos.x = hs.x
		player.lastpos.y = hs.y
	end
end

hotspot.all[1].update = function(self,dt)
	local dx = self.x - player.x
	local dy = self.y - player.y
	local praying = false
	if (dx*dx+dy*dy)<saveDist*saveDist then
		targetHSV(140,0.3,0.8)
	end
end

for i=2,6 do
	hotspot.all[i].update = savePoint
end
hotspot.all[12].update = savePoint

hotspot.all[7].time = 0
hotspot.all[7].sound = love.audio.newSource("audio/PrayerLoop.ogg")
hotspot.all[7].sound:setPitch(0)
hotspot.all[7].sound:setVolume(0)
hotspot.all[7].sound:setLooping(true)
hotspot.all[7].sound:play()
hotspot.all[7].count = 0

hotspot.all[7].sparkled = function(self,x,y)
	self.count = self.count+1
end

hotspot.all[7].update = function(self,dt)
	local dx = self.x - player.x
	local dy = self.y - player.y
	local praying = false
	if (dx*dx+dy*dy)<saveDist*saveDist then
		praying = true
	end
	if self.time>0.05 then
		sparkle.cheat(self,praying)
		self.time = 0
	end
	self.count = math.max(0,self.count-dt*3)
	local val = (self.count)/20
	self.sound:setVolume(val)
	self.sound:setPitch(val*2)
	if self.count>20 then
		levelscreen.get(31,55).type = 0
		levelscreen.get(31,56).type = 0
		levelscreen.get(31,57).type = 0
		print("Cool")
		snd.prayed:rewind()
		snd.prayed:play()
		sparkle.impulse(player.x,player.y)
		self.sound:stop()
		self.update = function() end
	end
	self.time = self.time+dt
end

hotspot.all[8].time = 0
hotspot.all[8].sound = love.audio.newSource("audio/PrayerLoop.ogg")
hotspot.all[8].sound:setPitch(0)
hotspot.all[8].sound:setVolume(0)
hotspot.all[8].sound:setLooping(true)
hotspot.all[8].sound:play()
hotspot.all[8].count = 0

hotspot.all[8].sparkled = function(self,x,y)
	self.count = self.count+1
end

hotspot.all[8].update = function(self,dt)
	local dx = self.x - player.x
	local dy = self.y - player.y
	local praying = false
	if (dx*dx+dy*dy)<saveDist*saveDist then
		praying = true
	end
	if self.time>0.05 then
		sparkle.cheat(self,praying)
		self.time = 0
	end
	self.count = math.max(0,self.count-dt*3)
	local val = (self.count)/50
	self.sound:setVolume(val)
	self.sound:setPitch(val*2)
	if self.count>50 then
		targetHSV(200,0,1)
		sparkle.all = {}
		for i=1,100 do
			sparkle.cheat(self)
		end
		snd.prayed:rewind()
		snd.intro:stop()
		snd.thesoul:stop()
		snd.nopain:play()
		snd.wind1:stop()
		snd.wind2:stop()
		sparkle.impulse(player.x,player.y)
		self.sound:stop()
		self.draw = function() end
		self.update = function() end
		player.update = function() end
		player.draw = function() end
	end
	self.time = self.time+dt
end

hotspot.all[8].draw = function(self)
	if GLOBAL.mode == "edit" then
		love.graphics.circle("line",self.x, self.y,10)
		love.graphics.print(self.id,self.x-5,self.y-5)
	end
	local val = (self.count)/50
	love.graphics.setColor(val*10,val*10,val*10)
	love.graphics.setBlendMode("additive")
	for i=1,10 do

		love.graphics.rectangle("fill",self.x-i*i*(1-val),self.y-256,i*i*(1-val)*2,256)
	end
	love.graphics.setBlendMode("alpha")
end

hotspot.all[9].time = 0
hotspot.all[9].sound = love.audio.newSource("audio/PrayerLoop.ogg")
hotspot.all[9].sound:setPitch(0)
hotspot.all[9].sound:setVolume(0)
hotspot.all[9].sound:setLooping(true)
hotspot.all[9].sound:play()
hotspot.all[9].count = 0

hotspot.all[9].sparkled = function(self,x,y)
	self.count = self.count+1
end

hotspot.all[9].update = function(self,dt)
	local dx = self.x - player.x
	local dy = self.y - player.y
	local praying = false
	if (dx*dx+dy*dy)<saveDist*saveDist then
		praying = true
	end
	if self.time>0.05 then
		sparkle.cheat(self,praying)
		self.time = 0
	end
	self.count = math.max(0,self.count-dt*3)
	local val = (self.count)/20
	self.sound:setVolume(val)
	self.sound:setPitch(val*2)
	if self.count>20 then
		print("erro!")
		levelscreen.get(51,16).type = 0
		snd.prayed:rewind()
		snd.prayed:play()
		sparkle.impulse(player.x,player.y)
		self.sound:stop()
		self.update = function() end
	end
	self.time = self.time+dt
end

hotspot.all[10].time = 0
hotspot.all[10].sound = love.audio.newSource("audio/PrayerLoop.ogg")
hotspot.all[10].sound:setPitch(0)
hotspot.all[10].sound:setVolume(0)
hotspot.all[10].sound:setLooping(true)
hotspot.all[10].sound:play()
hotspot.all[10].count = 0

hotspot.all[10].sparkled = function(self,x,y)
	self.count = self.count+1
end

hotspot.all[10].update = function(self,dt)
	local dx = self.x - player.x
	local dy = self.y - player.y
	local praying = false
	if (dx*dx+dy*dy)<saveDist*saveDist then
		praying = true
	end
	if self.time>0.05 then
		sparkle.cheat(self,praying)
		self.time = 0
	end
	self.count = math.max(0,self.count-dt*3)
	local val = (self.count)/20
	self.sound:setVolume(val)
	self.sound:setPitch(val*2)
	if self.count>20 then
		print("erro!")
		levelscreen.get(59,16).type = 0
		levelscreen.get(59,17).type = 0
		snd.prayed:rewind()
		snd.prayed:play()
		sparkle.impulse(player.x,player.y)
		sparkle.box(58*16,15*16,16,16,20)
		sparkle.box(58*16,16*16,16,16,20)
		self.sound:stop()
		self.update = function() end
	end
	self.time = self.time+dt
end

hotspot.all[11].time = 0
hotspot.all[11].sound = love.audio.newSource("audio/PrayerLoop.ogg")
hotspot.all[11].sound:setPitch(0)
hotspot.all[11].sound:setVolume(0)
hotspot.all[11].sound:setLooping(true)
hotspot.all[11].sound:play()
hotspot.all[11].count = 0

hotspot.all[11].sparkled = function(self,x,y)
	self.count = self.count+1
end

hotspot.all[11].update = function(self,dt)
	local dx = self.x - player.x
	local dy = self.y - player.y
	local praying = false
	if (dx*dx+dy*dy)<saveDist*saveDist then
		praying = true
	end
	if self.time>0.05 then
		sparkle.cheat(self,praying)
		self.time = 0
	end
	self.count = math.max(0,self.count-dt*3)
	local val = (self.count)/20
	self.sound:setVolume(val)
	self.sound:setPitch(val*2)
	if self.count>20 then
		print("erro!")
		levelscreen.get(78,24).type = 0
		levelscreen.get(79,24).type = 0
		snd.prayed:rewind()
		snd.prayed:play()
		sparkle.impulse(player.x,player.y)
		self.sound:stop()
		self.update = function() end
	end
	self.time = self.time+dt
end

hotspot.all[13].update = function(self,dt)
	local dx = self.x - player.x
	local dy = self.y - player.y
	local praying = false
	if (dx*dx+dy*dy)<saveDist*saveDist then
		targetHSV(140,0.0,0.2)
	end
end

hotspot.all[15].update = function(self,dt)
	local dx = self.x - player.x
	local dy = self.y - player.y
	local praying = false
	if (dx*dx+dy*dy)<saveDist*saveDist then
		targetHSV(300,0.0,0.2)
	end
end

hotspot.all[14].update = function(self,dt)
	local dx = self.x - player.x
	local dy = self.y - player.y
	local praying = false
	if (dx*dx+dy*dy)<saveDist*saveDist then
		targetHSV(300,0.7,1)
	end
end

hotspot.all[17].update = function(self,dt)
	local dx = self.x - player.x
	local dy = self.y - player.y
	local praying = false
	if (dx*dx+dy*dy)<saveDist*saveDist then
		targetHSV(300,0.7,1)
	end
end

hotspot.all[16].update = function(self,dt)
	local dx = self.x - player.x
	local dy = self.y - player.y
	local praying = false
	if (dx*dx+dy*dy)<saveDist*saveDist then
		targetHSV(200,0.5,1)
	end
end

hotspot.all[18].time = 0
hotspot.all[18].sound = love.audio.newSource("audio/PrayerLoop.ogg")
hotspot.all[18].sound:setPitch(0)
hotspot.all[18].sound:setVolume(0)
hotspot.all[18].sound:setLooping(true)
hotspot.all[18].sound:play()
hotspot.all[18].count = 0

hotspot.all[18].sparkled = function(self,x,y)
	self.count = self.count+1
end

hotspot.all[18].update = function(self,dt)
	local dx = self.x - player.x
	local dy = self.y - player.y
	local praying = false
	if (dx*dx+dy*dy)<saveDist*saveDist then
		praying = true
	end
	if self.time>0.05 then
		sparkle.cheat(self,praying)
		self.time = 0
	end
	self.count = math.max(0,self.count-dt*3)
	local val = (self.count)/20
	self.sound:setVolume(val)
	self.sound:setPitch(val*2)
	if self.count>20 then
		print("erro!")
		levelscreen.get(4,33).type = 0
		levelscreen.get(5,33).type = 0
		snd.prayed:rewind()
		snd.prayed:play()
		sparkle.impulse(player.x,player.y)
		self.sound:stop()
		self.update = function() end
	end
	self.time = self.time+dt
end

print("Loaded the hotspot script")