local tile_mt = {}
tile = {}


tile.images = {}
tile.images.earthy = love.graphics.newImage("images/earthy.png")
tile.images.earthybatch = love.graphics.newSpriteBatch(tile.images.earthy,20000)

function tile.new()
	local self = setmetatable({},{__index=tile_mt})
	self.collide = false
	return self
end

tile.default = tile.new()
tile.default.collide = true

function tile_mt:update(dt,x,y)

end

function tile_mt:draw(x, y)
	if self.collide then
		love.graphics.setColor(255,255,255)
		--love.graphics.rectangle("fill",(x-1)*16,(y-1)*16,16,16)
		tile.images.earthybatch:add((x-1)*16-4,(y-1)*16-4)
	else
	end
end

function tile_mt:tweak()
	self.collide = not self.collide
end
