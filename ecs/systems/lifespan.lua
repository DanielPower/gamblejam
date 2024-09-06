local LifespanSystem = Concord.system({
    pool = { "lifespan" }
})

function LifespanSystem:update(dt)
    for _, entity in ipairs(self.pool) do
        entity.lifespan.remaining = entity.lifespan.remaining - dt
        if entity.lifespan.remaining <= 0 then
            entity:destroy()
        end
    end
end

return LifespanSystem
