Concord.component("player", function(c, keys)
    c.keys = keys
end)

Concord.component("enemy")

Concord.component("gravity", function(c, x, y)
    c.x = x or 0
    c.y = y or 600
end)

Concord.component("position", function(c, x, y)
    c.x = x
    c.y = y
end)

Concord.component("velocity", function(c, x, y)
    c.x = x
    c.y = y
    c.tx = 0
    c.ty = 0
end)

Concord.component("box", function(c, width, height)
    c.width = width
    c.height = height
end)

Concord.component("animation", function(c, image, animation)
    c.image = image
    c.animation = animation:clone()
    c.flipX = false
    c.flipY = false
end)

Concord.component("jump", function(c, jumpHeight, maxJumps)
    c.speed = jumpHeight
    c.maxJumps = maxJumps or 1
    c.jumps = 0
end)

Concord.component("lifespan", function(c, duration)
    c.duration = duration
    c.remaining = duration
end)
