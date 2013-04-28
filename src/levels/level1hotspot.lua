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
	self.count = self.count-dt*3
	if self.count>10 then
		sparkle.impulse(player.x,player.y)
		self.update = function() end
	end
	self.time = self.time+dt
end

print("Loaded the hotspot script")