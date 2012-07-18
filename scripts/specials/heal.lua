-- [[
-- Logic of the heal spell. The heal spell allows to heal the targeted character.
-- ]]

-- Constants related to the spell
local skill_name = "Magic_Heal"
local heal = 20
local range = 6 * TILESIZE

local spell = get_special_info("Magic_Heal")
spell:on_use(function(user, target, special_id)
    if not target or being_type(target) ~= TYPE_CHARACTER and target ~= user then
        return
    end

    local exp = chr_get_exp(user, skill_name)
    local factor = math.max(chr_get_level(user, skill_name) / 10, 1)
    local heal_mod = heal * factor

    --effect_create(11, target)
    chr_set_special_mana(user, special_id, 0)
    
    local current_hp = being_get_modified_attribute(target, ATTR_HP)
    local max_hp = being_get_modified_attribute(target, ATTR_MAX_HP)

    heal_mod = math.min(heal_mod, max_hp - current_hp)
    local gained_exp = math.floor(heal_mod / 10)
    
    being_set_base_attribute(target, ATTR_HP, current_hp + heal_mod)
    chr_give_exp(user, skill_name, gained_exp)
    
end)
