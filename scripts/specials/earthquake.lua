--[[

  Definition of the earthquake spell. The spell does area damage to all beings
  around the player

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
local skill_name = "Magic_Earthquake"
local damage = 30
local damage_delta = 5
local damage_cth = 20
local damage_element = ELEMENT_EARTH
local damage_type = DAMAGE_PHYSICAL -- MAGIC does not work atm
local range = 3 * TILESIZE

local spell = get_special_info("Magic_Earthquake")
spell:on_use(function(user, target, special_id)
    local damage_mod = damage * get_special_factor(user, skill_name)

    effect_create(1, user)
    chr_set_special_mana(user, special_id, 0)
    recalculate_special_rechargespeed(user, special_id)

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
