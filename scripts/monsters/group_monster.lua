-- [[
-- Script that can be called from other monster scripts which shares the
-- anger between the monsters.
-- ]]

-- Calling this function will make all monsters of same id attack the aggressor
function damage_recieved(mob, aggressor, hploss)
    local beings = get_beings_in_circle(mob, 10 * TILESIZE)
    local id = monster_get_id(mob)
    for _, being in ipairs(beings) do
        if (being_type(being) == TYPE_MONSTER and monster_get_id(being) == id) then
            monster_change_anger(being, aggressor, hploss)
        end
    end
end
