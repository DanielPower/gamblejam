love.graphics.setDefaultFilter("nearest", "nearest")

Concord = require("lib.concord")
FileWatcher = require("lib.watcher")
Inspect = require("lib.inspect")
Pprint = require("lib.pprint")

require("ecs.components")

local animations = require("animations")

local ldtk = require("lib.ldtk")
local DrawSystem = require("ecs.systems/draw")
local PlayerSystem = require("ecs.systems/player")
local GravitySystem = require("ecs.systems/gravity")
local PhysicsSystem = require("ecs.systems/physics")
local LifespanSystem = require("ecs.systems/lifespan")
local GhostSystem = require("ecs.systems/ai/ghost")

local player = require("ecs.assemblages/player")
local ghost = require("ecs.assemblages.ghost")

local GAME_WIDTH = 512
local GAME_HEIGHT = 288

GAME = {}

function love.load()
    GAME = {
        layers = {},
        levelWatcher = nil,
    }

    animations.load()
    ldtk:load("ldtk/levels.ldtk")
    ldtk:level("Level1")
end

function ldtk.onLevelLoaded(level)
    print("Loding level [" .. tostring(level.id) .. "]")
    GAME.layers = {}
    GAME.level = level
    GAME.world = Concord.world()
    GAME.canvas = love.graphics.newCanvas(512, 288)
end

function ldtk.onEntity(data)
    local e = Concord.entity(GAME.world):give("position", data.x, data.y)

    if data.id == "PlayerStart" then
        e:assemble(player, { left = "left", right = "right", jump = "c", attack = "v" })
    end

    if data.id == "Enemy" then
        if data.props.Type == "Ghost" then
            e:assemble(ghost)
        end
    end
end

function ldtk.onLayer(layer)
    for i, v in ipairs(layer.intGrid) do
        local x = (i - 1) % layer.width
        local y = math.floor((i - 1) / layer.width)
        if v == 1 then
            Concord.entity(GAME.world)
                :give("position", x * layer.gridSize, y * layer.gridSize)
                :give("box", layer.gridSize, layer.gridSize)
                :give("solid")
        end
    end
    GAME.layers[layer.id] = layer
end

function ldtk.onLevelCreated(level)
    GAME.world:addSystems(DrawSystem, PlayerSystem, GravitySystem, PhysicsSystem, LifespanSystem, GhostSystem)
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
    if key == "r" then
        love.event.quit("restart")
    end
    GAME.world:emit("keypressed", key)
end

function love.update(dt)
    GAME.fileWatcher.update()
    GAME.world:emit("update", dt)
end

function love.draw()
    love.graphics.setLineWidth(1)
    love.graphics.setLineStyle("rough")
    love.graphics.push("all")
    love.graphics.setCanvas(GAME.canvas)
    love.graphics.clear(0, 0, 0, 1)
    love.graphics.setColor(1, 1, 1, 1)
    for _, layer in pairs(GAME.layers) do
        layer:draw()
    end
    GAME.world:emit("draw")
    love.graphics.pop()

    love.graphics.setCanvas()
    love.graphics.draw(
        GAME.canvas,
        0,
        0,
        0,
        love.graphics.getWidth() / GAME_WIDTH,
        love.graphics.getHeight() / GAME_HEIGHT
    )
end
