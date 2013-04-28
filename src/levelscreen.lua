require("tile")
require("filer")

local levelscreen_mt = {}

local imfile = love.filesystem.newFile("levels/level1.png")
imfile:open("r")
levelone = love.image.newImageData(imfile)
imfile:close()


levelscreen = {}



function levelscreen.new(name, levelname)
	local self = {}
	if love.filesystem.exists("levels/"..levelname..".lua") then
		self = filer.fromFile("levels/"..levelname..".lua")
	end
	setmetatable(self,{__index = levelscreen_mt})
	local imageData = love.image.newImageData("levels/"..levelname..".png")
	self.decoration = self.decoration or {}
	self.name = name or "Default screen"
	self.map = {}
	self.xsize = imageData:getWidth()
	self.ysize = imageData:getHeight()
	for i=0,imageData:getWidth()-1 do
		self.map[i+1]={}
		for j=0,levelone:getHeight()-1 do
			self.map[i+1][j+1] = tile.new(imageData:getPixel(i,j))
		end
	end
	return self
end

levelscreen.current = levelscreen.new("Level One","level1")

function levelscreen.toImageData(file)
	return levelscreen.current:toImageData(file)
end

function levelscreen_mt:toImageData(filename)
	local imageData = love.image.newImageData( self.xsize+1, self.ysize+1 )
	for i=0,imageData:getWidth() do
		for j=0,levelone:getHeight() do
			if self.map[i+1] and self.map[i+1][j+1] and self.map[i+1][j+1].toPixel then
				local r,g,b,a = self.map[i+1][j+1]:toPixel()
				imageData:setPixel(i,j,r,g,b,a)
			end
		end
	end
	if filename then
		love.filesystem.mkdir("levels")
		imageData:encode("levels/"..filename)
	end
	return imageData
end

function levelscreen.toLuaScript(filename)
	levelscreen.current:toLuaScript(filename)
end

function levelscreen_mt:toLuaScript( filename )
	filer.toFile("levels/"..filename..".lua", {decoration = self.decoration})
end

function levelscreen.decorate(deco)
	levelscreen.current:decorate(deco)
end

function levelscreen_mt:decorate(deco)
	table.insert(self.decoration,deco)
end

function levelscreen.removeLastDeco()
	levelscreen.current:removeLastDeco()
end

function levelscreen_mt:removeLastDeco()
	table.remove(self.decoration,#self.decoration)
end

function levelscreen.update(dt)
	levelscreen.current:update(dt)
end

function levelscreen_mt:update(dt)
	for i,v in ipairs(self.map) do
		for j,u in ipairs(v) do
			u:update(dt,i,j)
		end
	end
	for i,v in ipairs(self.decoration) do
		v:update(dt)
	end
end

function levelscreen.draw()
	levelscreen.current:draw()
end

function levelscreen_mt:draw()

	love.graphics.setColor(useful.hsv(GLOBAL.bghue,GLOBAL.bgsat, GLOBAL.bgval))
	for i,v in ipairs(self.decoration) do
		v:draw()
	end

	tile.images.collbatch:clear()
	local px, py = player.getScreen()
	for i=px*12,px*12+13 do
		for j=py*12,py*12+13 do
			local t = levelscreen
			levelscreen.get(i,j):draw(i,j)
		end
	end
	love.graphics.setColor(useful.hsv(GLOBAL.fghue,GLOBAL.fgsat, GLOBAL.fgval))
	love.graphics.draw(tile.images.collbatch)
end

function levelscreen.tweak(x,y,dir)
	levelscreen.getPixel(x,y):tweak(dir)
end

function levelscreen.get(x,y)
	if x<=0 or x>=levelscreen.current.xsize or y<=0 or y>=levelscreen.current.ysize then
		return tile.default
	else
		return levelscreen.current.map[x][y] or tile.default
	end
end

function levelscreen.getPixel(x,y)
	local tx = math.floor(x/16)
	local ty = math.floor(y/16)
	if tx<0 or tx>=levelscreen.current.xsize-1 or ty<0 or ty>=levelscreen.current.ysize-1 then
		return tile.new(1,0,0,255)
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
				return true, divx+modx, divy+16-modx, true
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
		return false, divx+modx, divy+mody, true
	end
end