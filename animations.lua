local anim8 = require("lib.anim8")

local animations = {}

function animations.load()
    local towerfall = love.graphics.newImage("assets/towerfall.png")
    local slash = love.graphics.newImage("assets/slashes.png")

    local towerfallGrid = anim8.newGrid(
        12,
        16,
        towerfall:getWidth(),
        towerfall:getHeight(),
        796,
        1970
    )

    local ghostGrid = anim8.newGrid(
        16,
        24,
        towerfall:getWidth(),
        towerfall:getHeight(),
        868,
        0
    )

    local slashGrid = anim8.newGrid(
        32,
        32,
        slash:getWidth(),
        slash:getHeight()
    )

    animations.idle = {
        image = towerfall,
        animate = anim8.newAnimation(towerfallGrid("1-7", 1), 0.1)
    }
    animations.slash = {
        image = slash,
        animate = anim8.newAnimation(slashGrid("1-6", 1), 0.05)
    }
    animations.ghost = {
        image = towerfall,
        animate = anim8.newAnimation(ghostGrid("1-6", 1), 0.1)
    }
end

return animations
