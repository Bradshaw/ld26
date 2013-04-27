local tile_mt = {}
tile = {}


tile.type = {}

tile.type.EMPTY = 0
tile.type.FULL = 1
tile.type.TOPLEFT = 2
tile.type.BOTTOMLEFT = 3
tile.type.TOPRIGHT = 4
tile.type.BOTTOMRIGHT = 5



tile.images = {}
tile.images.earthy = love.graphics.newImage("images/earthy.png")
tile.images.earthybatch = love.graphics.newSpriteBatch(tile.images.earthy,20000)

function tile.new()
	local self = setmetatable({},{__index=tile_mt})
	self.type = tile.type.EMPTY
	return self
end

tile.default = tile.new()
tile.default.type = tile.type.FULL

function tile_mt:update(dt,x,y)

end

function tile_mt:fromPixel(r,g,b,a)
	if r==0 then
		self.type=tile.type.FULL
	else
		self.type=tile.type.EMPTY
	end
end

function tile_mt:draw(x, y)
	if self.type == tile.type.FULL then
		love.graphics.setColor(255,255,255)
		--love.graphics.rectangle("fill",(x-1)*16,(y-1)*16,16,16)
		tile.images.earthybatch:add((x-1)*16-4,(y-1)*16-4)
	elseif self.type~=tile.type.EMPTY then
		love.graphics.setColor((self.type*5)%3*127,(self.type*3)%3*127,self.type%2*127)
		love.graphics.rectangle("fill",(x-1)*16,(y-1)*16,16,16)
	end
end

function tile_mt:tweak(direction)
	direction = direction or 1
	self.type = (self.type+direction)%6
end
