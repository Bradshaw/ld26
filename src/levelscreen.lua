require("tile")

local levelscreen_mt = {}

levelone = love.image.newImageData("levels/level1.png")

levelscreen = {}



function levelscreen.new(name, imageData)
	local self = setmetatable({},{__index = levelscreen_mt})
	self.name = name or "Default screen"
	self.map = {}
	self.xsize = levelone:getWidth()-1
	self.ysize = levelone:getHeight()-1
	for i=1,levelone:getWidth()-1 do
		self.map[i]={}
		for j=1,levelone:getHeight()-1 do
			self.map[i][j] = tile.new()
			local r,g,b,a = levelone:getPixel(i,j)
			if r<127 then
				self.map[i][j].type = tile.type.FULL
			end
		end
	end
	return self
end

levelscreen.current = levelscreen.new()



function levelscreen.update(dt)
	levelscreen.current:update(dt)
end

function levelscreen_mt:update(dt)
	for i,v in ipairs(self.map) do
		for j,u in ipairs(v) do
			u:update(dt,i,j)
		end
	end
end

function levelscreen.draw()
	levelscreen.current:draw()
end

function levelscreen_mt:draw()
	tile.images.collbatch:clear()
	local px, py = player.getScreen()
	for i=px*12,px*12+13 do
		for j=py*12,py*12+13 do
			levelscreen.get(i,j):draw(i,j)
		end
	end
	love.graphics.draw(tile.images.collbatch)
end

function levelscreen.tweak(x,y,dir)
	levelscreen.getPixel(x,y):tweak(dir)
end

function levelscreen.get(x,y)
	if x<=0 or x>=levelscreen.current.xsize or y<=0 or y>=levelscreen.current.ysize then
		return tile.default
	else
		return levelscreen.current.map[x][y]
	end
end

function levelscreen.getPixel(x,y)
	local tx = math.floor(x/16)
	local ty = math.floor(y/16)
	if tx<0 or tx>=levelscreen.current.xsize-1 or ty<0 or ty>=levelscreen.current.ysize-1 then
		return tile.default
	else
		return levelscreen.current.map[tx+1][ty+1]
	end
end

function levelscreen.getCollision(x,y)
	if levelscreen.getPixel(x,y).type == tile.type.EMPTY then
		return false
	elseif levelscreen.getPixel(x,y).type == tile.type.FULL then
		local modx, mody = x%16, y%16
		if modx>mody then
			return true, math.floor(x/16)*16+16, math.floor(y/16)*16
		else
			return true, math.floor(x/16)*16, math.floor(y/16)*16+16
		end
	else
		local modx, mody = x%16, y%16
		local divx, divy = math.floor(x/16)*16, math.floor(y/16)*16
		if levelscreen.getPixel(x,y).type == tile.type.TOPLEFT then
			if modx+mody<16 then
				return true, ivx+modx, divy+16-modx, true
			end
		elseif levelscreen.getPixel(x,y).type == tile.type.TOPRIGHT then
			if modx>mody then
				return true, divx+modx, divy+modx, true
			end
		elseif levelscreen.getPixel(x,y).type == tile.type.BOTTOMLEFT then
			if modx<mody then
				return true, divx+modx, divy+modx, true
			end
		elseif levelscreen.getPixel(x,y).type == tile.type.BOTTOMRIGHT then
			if modx+mody>16 then
				return true, divx+modx, divy+16-modx, true
			end
		end
		return false, divx+modx, divy+16-modx, true
	end
end