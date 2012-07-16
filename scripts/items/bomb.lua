-- [[
-- Bomb script that spawns a bomb that explodes after some time and deals damage
--
-- Authors:
-- + Ablu
-- ]]

local damage = 30
local damage_delta = 10
local accuracy = 200
local skillname = "Weapons_Bombing"
local effect_id = 6
local delay = 2
local range = 3 * TILESIZE
local function get_skill_factor(skill_exp)
    return math.max(1, math.log(skill_exp))
end

get_item_class(7):on("use", function(user)
    -- Assign on remove callback to prevent server crashs
    on_remove(user, function() user = nil end)
    
    local x, y = posX(user), posY(user)
    local exp = chr_get_exp(user, skillname)
    local damage_mod = get_skill_factor(exp) * damage


    schedule_in(delay, function()
        if not user then WARN("STOP"); return end

        local beings = get_beings_in_rectangle(x - range, y - range,
                                               2 * range, 2 * range)
        effect_create(effect_id, x, y)
        for _, being in ipairs(beings) do
            if being_type(being) == TYPE_MONSTER or being == user or
               (map_get_pvp() == PVP_FREE and being_type(being) == TYPE_CHARACTER) then
                WARN("DAMAGE")
                
                being_damage(being, damage_mod, damage_delta, accuracy,
                             DAMAGE_PHYSICAL, ELEMENT_EARTH, user, skillname)
            end
        end
    end)
end)
