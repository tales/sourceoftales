-- [[
-- Definition of the firelion spell. The spell does area damage to all beings in
-- front of the using character.
--
-- Authors:
-- + Ablu
-- ]]

-- Constants related to the spell
local skill_name = "Magic_Fire Lion"
local damage = 30
local damage_delta = 5
local damage_cth = 20
local damage_element = ELEMENT_FIRE
local damage_type = DAMAGE_PHYSICAL -- MAGIC does not work atm

local spell = get_special_info("Magic_Fire Lion")
spell:on_use(function(user, target, special_id)
    WARN("USE")
    local exp = chr_get_exp(user, skill_name)
    WARN("LEVEL: " .. chr_get_level(user, skill_name))
    local factor = math.max(chr_get_level(user, skill_name) / 10, 1)
    WARN("factor: " .. factor)
    local damage_mod = damage * factor
    WARN("damge: " .. damage_mod)

    local x, y, w, h, effect_id
    local direction = being_get_direction(user)
    if direction == DIRECTION_UP then
        x = posX(user) - 1.5 * TILESIZE
        y = posY(user) - 2 * TILESIZE
        w = 3 * TILESIZE
        h = 2 * TILESIZE
        effect_id = 8
    elseif direction == DIRECTION_DOWN then
        x = posX(user) - 1.5 * TILESIZE
        y = posY(user)
        w = 3 * TILESIZE
        h = 2 * TILESIZE
        effect_id = 7
    elseif direction == DIRECTION_LEFT then
        x = posX(user) - 2 * TILESIZE
        y = posY(user) - 1.5 * TILESIZE
        w = 2 * TILESIZE
        h = 3 * TILESIZE
        effect_id = 9
    elseif direction == DIRECTION_RIGHT then
        x = posX(user)
        y = posY(user) - 1.5 * TILESIZE
        w = 2 * TILESIZE
        h = 3 * TILESIZE
        effect_id = 10
    end

    effect_create(effect_id, posX(user), posY(user))
    chr_set_special_mana(user, special_id, 0)

    local beings = get_beings_in_rectangle(x, y, w ,h)
    for _, being in ipairs(beings) do
        if being ~= user and (being_type(being) == TYPE_MONSTER or 
           (map_get_pvp() == PVP_FREE and being_type(being) == TYPE_CHARACTER))
        then
            being_damage(being, damage_mod, damage_delta, damage_cth,
                         damage_type, damage_element, user, skill_name)
        end
    end
end)
