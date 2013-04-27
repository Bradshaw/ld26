local tile_mt = {}
tile = {}


tile.images = {}
tile.images.earthy = love.graphics.newImage("images/earthy.png")

function tile.new()
	local self = setmetatable({},{__index=tile_mt})
	self.collide = false
	return self
end


function tile_mt:update(dt,x,y)

end

function tile_mt:draw(x, y)
	if self.collide then
		love.graphics.setColor(255,255,255)
		--love.graphics.rectangle("fill",(x-1)*16,(y-1)*16,16,16)
		love.graphics.draw(tile.images.earthy,(x-1)*16-4,(y-1)*16-4)
	else
	end
end

function tile_mt:tweak()
	self.collide = not self.collide
end