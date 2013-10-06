--[[

 Offers damage functions

--]]

local monster_class_damage_functions = {}

function MonsterClass:on_damaged(func)
    monster_class_damage_functions[self] = func
end

-- damage is a table with these keys:
-- base, delta, chance_to_hit
function Entity:damage(damage, source, experience_attribute)
    local hp_loss = math.random(damage.base, damage.base + damage.delta)
    local dodge = self:modified_attribute("Dodge")

    if (damage.chance_to_hit == 0) or (dodge > 0 and math.random(dodge) > math.random(damage.chance_to_hit))
    then
        hp_loss = 0 -- attack missed
    else
        local defense = self:modified_attribute("Defense")
        local randomness = hp_loss > 16 and math.random(hp_loss / 16) or 0
        hp_loss = hp_loss * (1 - (0.0159375 * defense) / (1 + 0.017 * defense))
                          + randomness
    end

    if hp_loss > 0 then
        local hp = self:base_attribute("HP")
        hp_loss = math.min(hp, hp_loss)

        if hp_loss == 0 then
            return
        end

        self:add_hit_taken(hp_loss)
        self:set_base_attribute("HP", hp - hp_loss)

        if self:type() == TYPE_MONSTER then
            local class = get_monster_class(self:monster_id())
            local callback = monster_class_damage_functions[class]
            if callback then
                return callback(self, source, hp_loss, experience_attribute)
            end
        end
    end
end
