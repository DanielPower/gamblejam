Concord = require("lib.concord")
FileWatcher = require("lib.watcher")
inspect = require("lib.inspect")
pprint = require("lib.pprint")
ldtk = require("lib.ldtk")
require("ecs.components")

local DrawSystem = require("ecs.systems/draw")

GAME = {}

function love.load()
	GAME = {
		layers = {},
		levelWatcher = nil,
	}

	ldtk:load("ldtk/levels.ldtk")
	ldtk:level("Level1")
end

function ldtk.onLevelLoaded(level)
	print("Loding level", level.id)
	GAME.layers = {}
	GAME.level = level
	GAME.world = Concord.world()
	GAME.world:addSystems(DrawSystem)
	GAME.fileWatcher = FileWatcher("ldtk/levels/" .. level.id .. ".ldtkl", function()
		print("Level [" .. level.id .. "] has changed. Reloading...")
		ldtk:load("ldtk/levels.ldtk")
		ldtk:level("Level1")
	end)
end

function ldtk.onEntity(data)
	print("level:")
	pprint(GAME.level)
	local e = Concord.entity(GAME.world):give("position", data.x, data.y)

	if data.id == "PlayerStart" then
		e:give("player")
	end

	if data.id == "Enemy" then
		e:give("enemy")
	end

	pprint(entity)
	-- A new entity is created.
end

function ldtk.onLayer(layer)
	-- print("onLayer")
	GAME.layers[layer.id] = layer
end

function ldtk.onLevelCreated(level)
	-- print("onLevelCreated")
end

function love.update(dt)
	GAME.fileWatcher.update()
	GAME.world:emit("update", dt)
end

function love.draw()
	for _, layer in pairs(GAME.layers) do
		layer:draw()
	end
	GAME.world:emit("draw")
end
