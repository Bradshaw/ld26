local decoration_mt = {}
decoration = {}

decoration.images = {}
local i = 1
while love.filesystem.exists("images/deco"..string.format("%02d",i)..".png") do
	print("Loaded : ".."images/deco"..string.format("%02d",i)..".png")
	decoration.images[i] = love.graphics.newImage("images/deco"..string.format("%02d",i)..".png")
	i=i+1
end

decoration.currentImage = 1


function decoration.new(x, y, image)
	local self = setmetatable({},{__index = decoration_mt})
	self.rotation = ((math.random()-0.5)*2) * 0.05
	self.x = x
	self.y = y
	self.image = image
	return self
end

function decoration_mt:update(dt)
	
end

function decoration_mt:draw()
	love.graphics.draw(decoration.images[self.image],self.x,self.y,self.rotation)
end