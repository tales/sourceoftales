-- [[
-- Definition of the lithning spell. It does damage to the selected target only.
--
-- Authors:
-- + Ablu
-- ]]

-- Constants related to the spell
local skill_name = "Magic_Lightning"
local damage = 40
local damage_delta = 5
local damage_cth = 20
local damage_element = ELEMENT_LIGHTNING
local damage_type = DAMAGE_PHYSICAL -- MAGIC does not work atm
local range = 6 * TILESIZE

local spell = get_special_info("Magic_Lightning")
spell:on_use(function(user, target, special_id)
    if not target or (being_type(target) ~= TYPE_MONSTER and
        (map_get_pvp() ~= PVP_FREE and being_type(being) == TYPE_CHARACTER))
    then
        return
    end

    local exp = chr_get_exp(user, skill_name)
    local factor = math.max(chr_get_level(user, skill_name) / 10, 1)
    local damage_mod = damage * factor

    effect_create(11, target)
    chr_set_special_mana(user, special_id, 0)

    being_damage(target, damage_mod, damage_delta, damage_cth,
                 damage_type, damage_element, user, skill_name)
end)
