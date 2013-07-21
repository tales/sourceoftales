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
local attribute_name = "Magic/Earthquake"
local damage = {
    base = 30,
    delta = 5,
    chance_to_hit = 20,
}
local range = 3 * TILESIZE

local spell = get_ability_info("Magic/Earthquake")
spell:on_use(function(user, target, ability_id)
    local modded_damage = {
        base = damage.base * get_ability_factor(user, attribute_name),
        delta = damage.delta,
        chance_to_hit = damage.chance_to_hit,
    }

    effect_create(1, user)
    user:consume_ability(ability_id)

    local beings = get_beings_in_circle(user, range)
    for _, being in ipairs(beings) do
        if being ~= user and (being:type() == TYPE_MONSTER or
           (map_get_pvp() == PVP_FREE and being:type() == TYPE_CHARACTER))
        then
            being:damage(modded_damage, user, attribute_name)
        end
    end
end)
