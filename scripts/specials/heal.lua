--[[

  Logic of the heal spell. The heal spell allows to heal the targeted character.

  Copyright (C) 2012 Erik Schilling

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see <http://www.gnu.org/licenses/>.

--]]

-- Constants related to the spell
local skill_name = "Magic_Heal"
local heal = 20
local range = 6 * TILESIZE

local spell = get_special_info("Magic_Heal")
spell:on_use(function(user, target, special_id)
    target = target or user
    if target:type() ~= TYPE_CHARACTER and target ~= user then
        return
    end

    local heal_mod = heal * get_special_factor(user, skill_name)

    effect_create(12, target)
    
    local current_hp = target:modified_attribute(ATTR_HP)
    local max_hp = target:modified_attribute(ATTR_MAX_HP)

    heal_mod = math.min(heal_mod, max_hp - current_hp)
    local gained_exp = math.floor(heal_mod / 10)

    if heal_mod == 0 then
        return
    end
    
    target:set_base_attribute(ATTR_HP, current_hp + heal_mod)


    -- No exp for self heal
    if target ~= user then
        user:give_xp(skill_name, gained_exp)
    end
    
    user:set_special_mana(special_id, 0)
    recalculate_special_rechargespeed(user, special_id)
end)
