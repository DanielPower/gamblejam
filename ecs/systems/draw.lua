local DrawSystem = Concord.system({
	players = { "position", "player" },
	enemies = { "position", "enemy" },
})

function DrawSystem:draw()
	for _, e in ipairs(self.players) do
		love.graphics.setColor(0, 255, 0)
		love.graphics.circle("fill", e.position.x, e.position.y, 10)
	end

	for _, e in ipairs(self.enemies) do
		love.graphics.setColor(255, 0, 0)
		love.graphics.circle("fill", e.position.x, e.position.y, 10)
	end
end

return DrawSystem
