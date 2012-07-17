-- [[
-- Definition of the earthquake spell. The spell does area damage to all beings
-- around the player
--
-- Authors:
-- + Ablu
-- ]]

-- Constants related to the spell
local skill_name = "Magic_Earthquake"
local damage = 30
local damage_delta = 5
local damage_cth = 20
local damage_element = ELEMENT_EARTH
local damage_type = DAMAGE_PHYSICAL -- MAGIC does not work atm
local range = 3 * TILESIZE

local spell = get_special_info("Magic_Earthquake")
spell:on_use(function(user, target, special_id)
    local exp = chr_get_exp(user, skill_name)
    local factor = math.max(chr_get_level(user, skill_name) / 10, 1)
    local damage_mod = damage * factor

    effect_create(1, user)
    chr_set_special_mana(user, special_id, 0)

    local beings = get_beings_in_circle(user, range)
    for _, being in ipairs(beings) do
        if being ~= user and (being_type(being) == TYPE_MONSTER or 
           (map_get_pvp() == PVP_FREE and being_type(being) == TYPE_CHARACTER))
        then
            being_damage(being, damage_mod, damage_delta, damage_cth,
                         damage_type, damage_element, user, skill_name)
        end
    end
end)
