Concord = require("lib.concord")
FileWatcher = require("lib.watcher")
Inspect = require("lib.inspect")
Pprint = require("lib.pprint")

require("ecs.components")

local ldtk = require("lib.ldtk")
local DrawSystem = require("ecs.systems/draw")
local PlayerSystem = require("ecs.systems/player")
local MoveSystem = require("ecs.systems/move")
local GravitySystem = require("ecs.systems/gravity")

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
end

function ldtk.onEntity(data)
	local e = Concord.entity(GAME.world):give("position", data.x, data.y)

	if data.id == "PlayerStart" then
		e:give("player", {
			left = "a",
			right = "d",
			jump = "space",
		})
		e:give("velocity", 0, 0)
		e:give("gravity")
	end

	if data.id == "Enemy" then
		e:give("enemy")
	end
end

function ldtk.onLayer(layer)
	GAME.layers[layer.id] = layer
end

function ldtk.onLevelCreated(level)
	GAME.world:addSystems(DrawSystem, PlayerSystem, MoveSystem, GravitySystem)
	GAME.fileWatcher = FileWatcher("ldtk/levels/" .. level.id .. ".ldtkl", function()
		print("Level [" .. level.id .. "] has changed. Reloading...")
		ldtk:load("ldtk/levels.ldtk")
		ldtk:level("Level1")
	end)
end

function love.keypressed(key)
	if key == "escape" then
		love.event.quit()
	end
	GAME.world:emit("keypressed", key)
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
