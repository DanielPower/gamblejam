local PlayerSystem = Concord.system({
	players = { "position", "velocity", "player" },
})

local speed = 100
local jump = 220

function PlayerSystem:keypressed(key)
	for _, e in ipairs(self.players) do
		if key == e.player.keys.jump then
			e.velocity.y = -jump
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
	end
end

return PlayerSystem
