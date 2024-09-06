local animations = require("animations")

local function player(e, keys)
    e:give("player", keys)
    e:give("velocity", 0, 0)
    e:give("gravity")
    e:give("box", 12, 12)
    e:give("animation", animations.images.towerfall, animations.animations.towerfall.idle)
    e:give("jump", 220, 1)
    e:give("lifespan", 5)
end

return player
