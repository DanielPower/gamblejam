local GhostSystem = Concord.system({
    ghosts = { "position", "ghost", "velocity", "box" },
    players = { "position", "player" }
})

local GHOST_SPEED = 50
local PAUSE_DURATION = 1.5
local MOVE_DURATION = 3

function GhostSystem:update(dt)
    local player = self.players[1]
    if not player then return end

    for _, ghost in ipairs(self.ghosts) do
        if ghost.ghost.isMoving then
            ghost.ghost.moveTimer = ghost.ghost.moveTimer + dt
            if ghost.ghost.moveTimer >= MOVE_DURATION then
                ghost.ghost.isMoving = false
                ghost.ghost.pauseTimer = 0
                ghost.velocity.x = 0
                ghost.velocity.y = 0
            else
                local dx = player.position.x - ghost.position.x
                local dy = player.position.y - ghost.position.y
                local length = math.sqrt(dx * dx + dy * dy)
                if length > 0 then
                    ghost.velocity.x = (dx / length) * GHOST_SPEED
                    ghost.velocity.y = (dy / length) * GHOST_SPEED
                end
            end
        else
            ghost.ghost.pauseTimer = ghost.ghost.pauseTimer + dt
            if ghost.ghost.pauseTimer >= PAUSE_DURATION then
                ghost.ghost.isMoving = true
                ghost.ghost.moveTimer = 0
            end
        end
        for _, col in pairs(ghost.box.collisions.up) do
            if col.other.player and col.other.velocity.y > 0 then
                ghost:destroy()
            end
        end
    end
end

return GhostSystem
