Concord.component("player")
Concord.component("enemy")

Concord.component("position", function(c, x, y)
	c.x = x
	c.y = y
end)

Concord.component("velocity", function(c, x, y)
	c.x = x
	c.y = y
end)

Concord.component("debugCircle", function(c, radius, color)
	c.radius = radius
	c.color = color
end)
