local MoveSystem = Concord.system({
	pool = { "position", "velocity" },
})

function MoveSystem:update(dt)
	for _, e in ipairs(self.pool) do
		e.position.x = e.position.x + (e.velocity.x + e.velocity.tx) * dt
		e.position.y = e.position.y + (e.velocity.y + e.velocity.ty) * dt
		e.velocity.tx = 0
		e.velocity.ty = 0
	end
end

return MoveSystem
