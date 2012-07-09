-- [[
-- A map for testing features. This map is not accessible in game
--
-- Authors:
-- - Ablu
-- ]]

require "scripts/functions/patrol"

atinit(function()
    local mob_id = 2
    local patrol = Patrol:new(20 * TILESIZE, 20 * TILESIZE, 2)
    patrol:addWayPoint(25 * TILESIZE, 20 * TILESIZE)
    patrol:addWayPoint(30 * TILESIZE, 20 * TILESIZE)
    patrol:addWayPoint(35 * TILESIZE, 20 * TILESIZE)
    patrol:addWayPoint(40 * TILESIZE, 20 * TILESIZE)
    patrol:addWayPoint(35 * TILESIZE, 20 * TILESIZE)
    patrol:addWayPoint(30 * TILESIZE, 20 * TILESIZE)
    patrol:addWayPoint(25 * TILESIZE, 20 * TILESIZE)
    for i=1,10 do
        patrol:assignBeing(monster_create(mob_id, 20 * TILESIZE, 20 * TILESIZE))
    end
    schedule_every(5, function() patrol:logic(patrol) end)
end)

