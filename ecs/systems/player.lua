local PlayerSystem = Concord.system({
	players = { "position", "velocity", "player" },
})

function PlayerSystem:update(dt)
	for _, e in ipairs(self.players) do
		local speed = 100

		print("key", e.player.keys.left)
		if love.keyboard.isDown(e.player.keys.left) then
			print("move left")
			e.velocity.tx = -speed
		elseif love.keyboard.isDown(e.player.keys.right) then
			e.velocity.tx = speed
		end

		if love.keyboard.isDown(e.player.keys.jump) then
			e.velocity.y = -speed
		end
	end
end

return PlayerSystem
