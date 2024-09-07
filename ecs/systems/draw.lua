local DrawSystem = Concord.system({
    animations = { "position", "animation" },
})

function DrawSystem:update(dt)
    for _, a in ipairs(self.animations) do
        a.animation.animation:update(dt)
    end
end

function DrawSystem:draw()
    for _, a in ipairs(self.animations) do
        a.animation.animation:draw(
            a.animation.image,
            a.position.x,
            a.position.y,
            0,
            1,
            1,
            a.animation.ox,
            a.animation.oy
        )
    end
end

return DrawSystem
