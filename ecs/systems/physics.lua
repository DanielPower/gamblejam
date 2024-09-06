local bump = require("lib.bump")

local PhysicsSystem = Concord.system({
	bodies = { "position", "box" },
	moving = { "position", "box", "velocity" },
})

function PhysicsSystem:init()
	self.world = bump.newWorld()

	function self.bodies.onAdded(_, entity)
		self.world:add(
			entity,
			entity.position.x,
			entity.position.y,
			entity.box.width,
			entity.box.height
		)
	end

	function self.bodies.onRemoved(_, entity)
		self.world:remove(entity)
	end
end

function PhysicsSystem:update(dt)
	for _, entity in ipairs(self.moving) do
		local futureX = entity.position.x + (entity.velocity.x + entity.velocity.tx) * dt
		local futureY = entity.position.y + (entity.velocity.y + entity.velocity.ty) * dt
		entity.velocity.tx = 0
		entity.velocity.ty = 0

		local nextX, nextY, cols, len = self.world:move(entity, futureX, futureY)

		for i = 1, len do
			local col = cols[i]
			if col.normal.x ~= 0 then
				entity.velocity.x = 0
			end
			if col.normal.y ~= 0 then
				if col.normal.y < 0 then
					if entity.jump then
						entity.jump.jumps = 0
					end
				end
				entity.velocity.y = 0
			end
		end

		entity.position.x = nextX
		entity.position.y = nextY
	end
end

-- function PhysicsSystem:draw()
-- 	for _, entity in ipairs(self.bodies) do
-- 		love.graphics.rectangle(
-- 			"line",
-- 			math.floor(entity.position.x),
-- 			math.floor(entity.position.y),
-- 			entity.box.width,
-- 			entity.box.height
-- 		)
-- 	end
-- end

return PhysicsSystem
