local animations = require('animations')

local PlayerSystem = Concord.system({
    players = { "position", "velocity", "player" },
})

local speed = 100
local jump = 220

function PlayerSystem:keypressed(key)
    for _, e in ipairs(self.players) do
        if key == e.player.keys.jump and e.jump then
            if e.jump.jumps < e.jump.maxJumps then
                e.jump.jumps = e.jump.jumps + 1
                e.velocity.y = -e.jump.speed
            end
        end
        if key == e.player.keys.attack then
            e:getWorld():newEntity()
                :give("position", e.position.x, e.position.y)
                :give("velocity", 0, -200)
                :give("box", 8, 8)
                :give("lifespan", 1)
                :give("animation", animations.slash, { flipX = e.animation.animation.flippedH })
        end
    end
end

function PlayerSystem:update(dt)
    for _, e in ipairs(self.players) do
        if love.keyboard.isDown(e.player.keys.left) then
            e.velocity.tx = -speed
            if e.animation then
                e.animation.animation.flippedH = true
            end
        elseif love.keyboard.isDown(e.player.keys.right) then
            e.velocity.tx = speed
            if e.animation then
                e.animation.animation.flippedH = false
            end
        end
        for _, col in pairs(e.box.collisions.down) do
            if col.other.solid then
                e.jump.jumps = 0
            end
            if col.other.weakHead then
                col.other:destroy()
            end
        end
    end
end

return PlayerSystem
