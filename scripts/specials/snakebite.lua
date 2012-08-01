--[[

  Definition of the snake bite spell. It does damage to the selected target only.

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
local skill_name = "Magic_Snake Bite"
local damage = 40
local damage_delta = 5
local damage_cth = 20
local damage_element = ELEMENT_LIGHTNING
local damage_type = DAMAGE_PHYSICAL -- MAGIC does not work atm
local range = 6 * TILESIZE

-- offset of the snake relative to target
local offset = TILESIZE

local spell = get_special_info("Magic_Snake Bite")
spell:on_use(function(user, target, special_id)
    if not target or not (being_type(target) == TYPE_MONSTER or
        (map_get_pvp() == PVP_FREE and being_type(target) == TYPE_CHARACTER))
    then
        return
    end

    local damage_mod = damage * get_special_factor(user, skill_name)

    chr_set_special_mana(user, special_id, 0)
    recalculate_special_rechargespeed(user, special_id)

    -- Get direction
    local d_x = posX(target) - posX(user)
    local d_y = posY(target) - posY(user)
    local effect_id

    if math.abs(d_x) > math.abs(d_y) then
        if d_x > 0 then
            effect_id = 15
        else
            effect_id = 14
        end
    else
        if d_y > 0 then
            effect_id = 13
        else
            effect_id = 16
        end
    end

    effect_create(effect_id, posX(target), posY(target))


    being_damage(target, damage_mod, damage_delta, damage_cth,
                 damage_type, damage_element, user, skill_name)
end)
