local animations = require("animations")

local function ghost(e)
    e:give("ghost")
    e:give("animation", animations.ghost)
    e:give("velocity")
    e:give("box", 16, 24)
end

return ghost
