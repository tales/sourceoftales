--[[

  Definition of the lightning spell. It does damage to the selected target only.

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
local skill_name = "Magic_Lightning"
local damage = 40
local damage_delta = 5
local damage_cth = 20
local damage_element = ELEMENT_LIGHTNING
local damage_type = DAMAGE_PHYSICAL -- MAGIC does not work atm
local range = 6 * TILESIZE

local spell = get_special_info("Magic_Lightning")
spell:on_use(function(user, target, special_id)
    if not target or not (target:type() == TYPE_MONSTER or
        (map_get_pvp() == PVP_FREE and target:type() == TYPE_CHARACTER))
    then
        return
    end

    local damage_mod = damage * get_special_factor(user, skill_name)

    effect_create(11, target)
    user:set_special_mana(special_id, 0)
    recalculate_special_rechargespeed(user, special_id)

    target:damage(damage_mod, damage_delta, damage_cth,
                 damage_type, damage_element, user, skill_name)
end)
