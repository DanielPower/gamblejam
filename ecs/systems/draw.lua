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

	for _, e in ipairs(self.enemies) do
		love.graphics.setColor(255, 0, 0)
		love.graphics.circle("fill", e.position.x, e.position.y, 10)
	end
end

return DrawSystem
