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

hotspot.all[7].update = function(self,dt)
	local dx = self.x - player.x
	local dy = self.y - player.y
	if (dx*dx+dy*dy)<saveDist*saveDist then
		print("PRAISE DA LAWD")
	end
end

print("Loaded the hotspot script")