local hotspot_mt = {}
hotspot = {}

hotspot.all = {}

function hotspot.new(x,y)
	local self = setmetatable({},{__index=hotspot_mt})
	table.insert(hotspot.all,self)
	self.x = x
	self.y = y
	self.id = #hotspot.all
	return self
end

function hotspot.update(dt)
	for i,v in ipairs(hotspot.all) do
		v:update(dt)
	end
end

function hotspot_mt:update(dt)

end

function hotspot.draw()
	for i,v in ipairs(hotspot.all) do
		v:draw()
	end
end

function hotspot_mt:draw()
	if GLOBAL.mode == "edit" then
		love.graphics.circle("line",self.x, self.y,10)
		love.graphics.print(self.id,self.x-5,self.y-5)
	end
end