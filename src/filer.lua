require("dumper") --! Thank http://lua-users.org/wiki/PatrickRapin

filer = {}


--[[
Crache le contenu de "...", formaté, dans le stdout
]]
function filer.dump(...)
  print(DataDumper(...), "\n---")
end

--[[
Place le contenu de "..." dans un fichier "filename"
]]
function filer.toFile(filename, ...)
	love.filesystem.write(filename, DataDumper(...))
end

--[[
Lit le fichier "filename" et renvoie les données
]]
function filer.fromFile(filename, ...)
	local s = love.filesystem.read(filename)
	--print(s)
	return loadstring(s)()
end
	