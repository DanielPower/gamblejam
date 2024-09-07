Concord.component("player", function(c, keys)
    c.keys = keys
end)

Concord.component("gravity", function(c, x, y)
    c.x = x or 0
    c.y = y or 600
end)

Concord.component("position", function(c, x, y)
    c.x = x
    c.y = y
end)

Concord.component("velocity", function(c, x, y)
    c.x = x or 0
    c.y = y or 0
    c.tx = 0
    c.ty = 0
end)

Concord.component("box", function(c, width, height)
    c.width = width
    c.height = height
    c.collisions = {
        all = {},
        left = {},
        right = {},
        up = {},
        down = {}
    }
end)

Concord.component("animation", function(c, animation, options)
    options = options or {}
    c.animation = animation.animate:clone()
    c.image = animation.image
    c.flipX = options.flipX or false
    c.flipY = options.flipY or false
    c.ox = options.ox or 0
    c.oy = options.oy or 0
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

Concord.component("ghost", function(c)
    c.moveTimer = 0
    c.pauseTimer = 0
    c.isMoving = true
end)

Concord.component("solid")
