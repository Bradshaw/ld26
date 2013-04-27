require("tile")

local levelscreen_mt = {}

levelscreen_mt.map = {}
for i=1,12 do
	levelscreen_mt.map[i]={}
	for j=1,12 do
		levelscreen_mt.map[i][j] = tile.new()
	end
end
levelscreen = {}
levelscreen.current = setmetatable({},{__index = levelscreen_mt})
levelscreen.all = {}


function levelscreen.new(name)
	local self = setmetatable({},{__index = levelscreen_mt})
	self.name = name
	table.insert(levelscreen.all, self)
	return self
end

function levelscreen.setCurrent(level)
	if type(level)=="number" then
		levelscreen.current = levelscreen.all[level]
	elseif type(level)=="string" then
		for i,v in ipairs(levelscreen.all) do
			if v.name == level then
				levelscreen.current = v
				return i
			end
		end
	else
		levelscreen.current = level
	end
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
end

function levelscreen.draw()
	levelscreen.current:draw()
end

function levelscreen_mt:draw()
	for i,v in ipairs(self.map) do
		for j,u in ipairs(v) do
			u:draw(i,j)
		end
	end
end

function levelscreen.tweak(x,y)
	levelscreen.current:tweak(x,y)
end

function levelscreen_mt:tweak(x,y)
	if x>0 and x<=12 and y>0 and y<=12 then
		self.map[x][y]:tweak()
	end
end

function levelscreen.get(x,y)
	local tx = math.floor(x/16)
	local ty = math.floor(y/16)
	return levelscreen.current.map[(tx)%12+1][(ty)%12+1]
end