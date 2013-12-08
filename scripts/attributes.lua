--[[

 This file demonstrates how attributes are getting calculated and how they can
 be linked to each other.

 See http://doc.manasource.org/attributes.xml for more info.

--]]

local function recalculate_base_attribute(being, attribute)
    local attribute_name

    if type(attribute) == "string" then
        attribute_name = attribute
    else
        attribute_name = attribute:name()
    end

    local old_base = being:base_attribute(attribute)
    local new_base = old_base

    if attribute_name == "Accuracy" then
        -- Provisional
        new_base = being:modified_attribute("Dexterity")
    elseif attribute_name == "Defense" then
        new_base = 0.3 * being:modified_attribute("Vitality")
    elseif attribute_name == "Dodge" then
        -- Provisional
        new_base = being:modified_attribute("Agility")
    elseif attribute_name == "M. dodge" then
        -- TODO
        new_base = 1
    elseif attribute_name == "M. defense" then
        -- TODO
        new_base = 0
    elseif attribute_name == "Bonus att. speed" then
        -- TODO
        new_base = 0
    elseif attribute_name == "HP regeneration" then
        local hp_per_sec = being:modified_attribute("Vitality") * 0.05
        new_base = hp_per_sec * TICKS_PER_HP_REGENERATION / 10
    elseif attribute_name == "HP" then
        local hp = being:modified_attribute("HP")
        local max_hp = being:modified_attribute("Max HP")

        if hp > max_hp then
            new_base = new_base - hp - max_hp
        end
    elseif attribute_name == "Max HP" then
        local vit = being:modified_attribute("Vitality")
        new_base = (vit + 3) * (vit + 20) * 0.125
    elseif attribute_name == "Movement speed" then
        -- Provisional
        new_base = 3.0 + being:modified_attribute("Agility") * 0.08
    elseif attribute_name == "Capacity" then
        -- Provisional
        new_base = 2000 + being:modified_attribute("Strength") * 180
    elseif attribute_name == "Level" then
        local xp = being:base_attribute("XP")
        new_base = math.log(xp / 5 + math.pow(1.4, 3)) / math.log(1.4) - 2;
    elseif attribute_name == "Attackspeed" then
        -- TODO: for now hardcoded in the attacks
    elseif attribute_name == "Range" then
        new_base = 48 -- for now
    elseif attribute_name == "Damage" then
        if being:type() == TYPE_CHARACTER then
            new_base = being:modified_attribute("Strength")
        else
            new_base = 0
        end
    elseif attribute_name == "Hit chance" then
        new_base = being:modified_attribute("Accuracy")
    end

    if new_base ~= old_base then
        being:set_base_attribute(attribute_name, new_base)
    end

end

local function update_derived_attributes(being, attribute)
    local attribute_name = attribute:name()
    if attribute_name == "Strength" then
        recalculate_base_attribute(being, "Capacity")
        recalculate_base_attribute(being, "Damage")
    elseif attribute_name == "Agility" then
        recalculate_base_attribute(being, "Dodge")
    elseif attribute_name == "Accuracy" then
        recalculate_base_attribute(being, "Hit chance")
    elseif attribute_name == "Vitality" then
        recalculate_base_attribute(being, "Max HP")
        recalculate_base_attribute(being, "HP regeneration")
        recalculate_base_attribute(being, "Defense")
    elseif attribute_name == "Intelligence" then
        -- unimplemented
    elseif attribute_name == "Willpower" then
        -- unimplemented
    elseif attribute_name == "XP" then
        recalculate_base_attribute(being, "Level")
    end
end

on_recalculate_base_attribute(recalculate_base_attribute)
on_update_derived_attribute(update_derived_attributes)

function Entity:level()
    return math.floor(self:base_attribute("Level"))
end

function Entity:give_experience(experience, attribute)
    local old_experience = self:base_attribute(attribute or "XP")
    local old_level = self:level()
    self:set_base_attribute(attribute or "XP", old_experience + experience)
    if self:level() > old_level then
        self:say("LEVELUP!!!")
        self:set_attribute_points(self:attribute_points() + 3)
        self:set_correction_points(self:correction_points() + 1)
    end
end

local mobs_config = require "scripts/monsters/settings"

local exp_receiver = {}

-- Give EXP for monster kills
local function monster_damaged(mob, source, damage, experience_attribute)

    local receiver = exp_receiver[mob] or { chars = {}, total = 0 }
    exp_receiver[mob] = receiver

    if source and source:type() == TYPE_CHARACTER then
        mob:change_anger(source, damage)

        if #exp_receiver[mob].chars == 0 then
            on_remove(source, function(removed_being)
                receiver[removed_being] = nil
            end)
            on_death(source, function(removed_being)
                receiver[removed_being] = nil
            end)
            experience = {}
        end


        local character_info = receiver.chars[source]
        if not character_info then
            character_info = {experience = {}}
            receiver.chars[source] = character_info
        end
        local experience = receiver.chars[source].experience

        experience_attribute = experience_attribute or "XP"
        local current_experience = experience[experience_attribute]

        current_experience = (current_experience or 0) + damage
        experience[experience_attribute] = current_experience
        receiver.total = receiver.total + damage
    end

    if mob:base_attribute("HP") == 0 then
        local mob_config = mobs_config[mob:name()]
        local total_experience = mob_config.experience or 0
        for char, _ in pairs(receiver.chars) do
            for attribute, experience_amount in pairs(receiver.chars[char].experience) do
                local gained_exp = experience_amount / receiver.total * total_experience
                char:give_experience(gained_exp, attribute)
            end

            char:increment_kill_count(mob:monster_id())
        end

        if mob_config.drops then
            for _, drop in ipairs(mob_config.drops) do
                if drop.chance > math.random() then
                    local position_x, position_y = mob:position()
                    position_x = position_x + math.random(-TILESIZE, TILESIZE)
                    position_y = position_y + math.random(-TILESIZE, TILESIZE)
                    item_drop(position_x, position_y, drop.item)
                end
            end
        end
    end
end

for _, monsterclass in pairs(get_monster_classes()) do
    monsterclass:on_damaged(monster_damaged)
end
