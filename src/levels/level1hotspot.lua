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

for i=1,6 do
	hotspot.all[i].update = savePoint
end

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
	print(self.count,val)
	self.sound:setVolume(val)
	self.sound:setPitch(val*2)
	if self.count>20 then
		snd.prayed:rewind()
		snd.prayed:play()
		sparkle.impulse(player.x,player.y)
		self.sound:stop()
		self.update = function() end
	end
	self.time = self.time+dt
end

print("Loaded the hotspot script")