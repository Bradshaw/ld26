local sparkle_mt = {}
sparkle = {}

sparkle.max = 200
sparkle.maxage = 5

sparkle.all = {}

function sparkle.new(x,y,dx,dy,damp,accel,target)
	local self = setmetatable({},{__index=sparkle_mt})
	table.insert(sparkle.all,self)
	self.x = x
	self.y = y
	self.oldx = self.x
	self.oldy = self.y
	self.dx = dx
	self.dy = dy
	self.target = target
	self.accel = accel
	self.damp = damp
	self.age = 0
	return self
end

function sparkle.update(dt)
	if #sparkle.all > sparkle.max then
		for i=1,#sparkle.all-sparkle.max do
			print("killed a fucker")
			sparkle.all[i].purge = true
		end
	end
	local i = 1
	while i<=#sparkle.all do
		v = sparkle.all[i]
		if v.purge then
			table.remove(sparkle.all,i)
		else
			v:update(dt)
			i = i+1
		end
	end
end

function sparkle.impulse(x,y)
	for i,v in ipairs(sparkle.all) do
		local dx = x-v.x
		local dy = y-v.y
		local l = math.sqrt(dx*dx+dy*dy)
		v.dx = -dx/l*100
		v.dy = -dy/l*100
	end
end

function sparkle.draw()
	love.graphics.setBlendMode("additive")
	love.graphics.setColor(64,64,64)
	for i,v in ipairs(sparkle.all) do
		v:draw()
	end
	love.graphics.setBlendMode("alpha")
end

function sparkle_mt:update(dt)
	self.age = self.age+dt
	if self.age>sparkle.maxage then
		self.purge = true
	end
	if math.sqrt(self.dx*self.dx+self.dy*self.dy)<2 then
		self.purge = true
	end
	if self.target then
		local vx = self.target.x - self.x
		local vy = self.target.y - self.y
		self.dx = self.dx + math.sign(vx)*self.accel*dt
		self.dy = self.dy + math.sign(vy)*self.accel*dt
	end
	local dx = self.x - player.x
	local dy = self.y - player.y
	local praying = false
	if (dx*dx+dy*dy)<3*3 then
		if self.source then
			self.source:sparkled(self.x,self.y)
		end
		self.purge = true
	end

	self.dx = self.dx - self.dx*self.damp*dt
	self.dy = self.dy - self.dy*self.damp*dt
	self.oldx = self.x
	self.oldy = self.y
	self.x = self.x+self.dx*dt
	self.y = self.y+self.dy*dt
end

function sparkle_mt:draw()
	love.graphics.line(self.x,self.y,self.oldx,self.oldy)
end

function sparkle.cheat(source,aim)
	local sp = sparkle.new(
		source.x+math.random(-10,10),
		source.y+math.random(-5,5),
		math.random(-10,10),
		math.random(-50,-15)/2,
		0.5,
		100)
	if aim then
		sp.target = {x=player.x,y=player.y-6}
	end
	sp.source = source
end