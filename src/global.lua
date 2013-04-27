GLOBAL = {}


GLOBAL.mode = "play"  -- Determines gamemode, "play" for playing, "edit" for editing
GLOBAL.edittools = {}
table.insert(GLOBAL.edittools,"collisions")
table.insert(GLOBAL.edittools,"things")
table.insert(GLOBAL.edittools,"hotspots")

GLOBAL.currentTool = 1