local anim8 = require("lib.anim8")

local animations = {}

function animations.load()
	animations.images = {}
	animations.animations = {}

	animations.images.towerfall = love.graphics.newImage("assets/towerfall.png")

	local g = anim8.newGrid(
		12,
		16,
		animations.images.towerfall:getWidth(),
		animations.images.towerfall:getHeight(),
		796,
		1970
	)
	animations.animations.towerfall = {
		idle = anim8.newAnimation(g("1-7", 1), 0.1),
		walk = anim8.newAnimation(g("1-2", 1), 0.1),
		jump = anim8.newAnimation(g("1-3", 1), 0.1),
		fall = anim8.newAnimation(g("1-4", 1), 0.1),
	}
end

return animations
