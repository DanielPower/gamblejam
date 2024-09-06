local animations = require("animations")

local function player(e, keys)
    e:give("box", 16, 24)
    e:give("animation", animations.ghost)
end

return player
