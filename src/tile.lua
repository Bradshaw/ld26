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

tile.images.colltiles = love.graphics.newImage("images/colltiles.png")
tile.images.collbatch = love.graphics.newSpriteBatch(tile.images.colltiles,20000)
tile.images.collquads = {}
tile.images.collquads[0] = love.graphics.newQuad( 0, 0, 20, 20, 120, 20 )
tile.images.collquads[1] = love.graphics.newQuad( 20, 0, 20, 20, 120, 20 )
tile.images.collquads[2] = love.graphics.newQuad( 40, 0, 20, 20, 120, 20 )
tile.images.collquads[3] = love.graphics.newQuad( 60, 0, 20, 20, 120, 20 )
tile.images.collquads[4] = love.graphics.newQuad( 80, 0, 20, 20, 120, 20 )
tile.images.collquads[5] = love.graphics.newQuad( 100, 0, 20, 20, 120, 20 )


function tile.new(r,g,b,a)
	local self = setmetatable({},{__index=tile_mt})
	if r and g and b and a then
		self:fromPixel(r,g,b,a)
	else
		self.type = tile.type.EMPTY
	end
	return self
end

function tile_mt:update(dt,x,y)

end

function tile_mt:fromPixel(r,g,b,a)
	if r<6 then
		self.type=r
	else
		self.type=tile.type.EMPTY
	end
end

function tile_mt:toPixel()
	return self.type, 0, 0, 255
end

function tile_mt:draw(x, y)
	if self.type~=tile.type.EMPTY then
		tile.images.collbatch:addq(tile.images.collquads[self.type],(x-1)*16-2,(y-1)*16-2 )
		--love.graphics.setColor((self.type*5)%3*127,(self.type*3)%3*127,self.type%2*127)
		--love.graphics.rectangle("fill",(x-1)*16,(y-1)*16,16,16)
	end
end

function tile_mt:tweak(direction)
	direction = direction or 1
	self.type = (self.type+direction)%6
end

tile.default = tile.new(1,0,0,255)