local DrawSystem = Concord.system({
    players = { "position", "player" },
    enemies = { "position", "enemy" },
    animations = { "position", "animation" },
})

function DrawSystem:update(dt)
    for _, a in ipairs(self.animations) do
        a.animation.animation:update(dt)
    end
end

function DrawSystem:draw()
    for _, a in ipairs(self.animations) do
        a.animation.animation:draw(a.animation.image, a.position.x, a.position.y)
    end
end

return DrawSystem
