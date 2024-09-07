local animations = require("animations")

local function ghost(e)
    e:give("ghost")
    e:give("animation", animations.ghost, { ox = 3, oy = 5 })
    e:give("velocity")
    e:give("box", 9, 20)
end

return ghost
