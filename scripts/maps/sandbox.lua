-- [[
-- A map for testing features. This map is not accessible in game
--
-- Authors:
-- - Ablu
-- ]]

require "scripts/functions/guardpatrol"

atinit(function()
    local mob_id = 4
    local patrol = GuardPatrol:new("Patrol test", 5 * TILESIZE)
    for i=1,10 do
        patrol:assignBeing(monster_create(mob_id, get_named_coordinate("patrolspawn")))
    end
    schedule_every(1, function() patrol:logic() end)

    require "scripts/functions/trap"
    trap.assign_callback("trap", function(being) being_say(being, "I stepped on a TRAP!") end)
end)

