GLOBAL = {}


GLOBAL.mode = "play"  -- Determines gamemode, "play" for playing, "edit" for editing
GLOBAL.edittools = {}
table.insert(GLOBAL.edittools,"collisions")
table.insert(GLOBAL.edittools,"things")
table.insert(GLOBAL.edittools,"hotspots")

GLOBAL.currentTool = 1

function GLOBAL.makeColour(hue, sat, val)
	GLOBAL.hue  = hue or math.random(1, 360)
	GLOBAL.sat = sat or math.random()
	GLOBAL.val = val or math.random()
	GLOBAL.skyhue, GLOBAL.skysat, GLOBAL.skyval = GLOBAL.hue+40, 60*GLOBAL.sat, 20+70*GLOBAL.val
	GLOBAL.bghue, GLOBAL.bgsat, GLOBAL.bgval = GLOBAL.hue+20, 40*GLOBAL.sat, 20+30*GLOBAL.val
	GLOBAL.fghue, GLOBAL.fgsat, GLOBAL.fgval = GLOBAL.hue, 80*GLOBAL.sat, 50*GLOBAL.val
end

GLOBAL.makeColour()