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
local attribute_name = "Magic/Lightning"
local damage = {
    base = 40,
    delta = 5,
    chance_to_hit = 20
}
local range = 6 * TILESIZE

local spell = get_ability_info("Magic/Lightning")
spell:on_use(function(user, target, ability_id)
    if not target or not (target:type() == TYPE_MONSTER or
        (map_get_pvp() == PVP_FREE and target:type() == TYPE_CHARACTER))
    then
        return
    end

    effect_create(11, target)
    user:consume_ability(ability_id)

    local modded_damage = {
        base = damage.base * get_ability_factor(user, attribute_name),
        delta = damage.delta,
        chance_to_hit = damage.chance_to_hit,
    }

    target:damage(modded_damage, user, attribute_name)
end)
