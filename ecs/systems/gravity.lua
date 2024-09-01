local GravitySystem = Concord.system({
	pool = { "gravity", "velocity" },
})

function GravitySystem:update(dt)
	for _, e in ipairs(self.pool) do
		e.velocity.x = e.velocity.x + e.gravity.x * dt
		e.velocity.y = e.velocity.y + e.gravity.y * dt
	end
end

return GravitySystem
