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
    if not target or not (being_type(target) == TYPE_MONSTER or
        (map_get_pvp() == PVP_FREE and being_type(target) == TYPE_CHARACTER))
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
