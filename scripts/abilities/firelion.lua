--[[

  Definition of the firelion spell. The spell does area damage to all beings in
  front of the using character.

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
local attribute_name = "Magic/Fire Lion"
local damage = 30
local damage_delta = 5
local damage_cth = 20
local damage_element = ELEMENT_FIRE
local damage_type = DAMAGE_PHYSICAL -- MAGIC does not work atm

local spell = get_ability_info("Magic/Fire Lion")
spell:on_use(function(user, target, ability_id)
    local x, y, w, h, effect_id
    local direction = user:direction()
    if direction == DIRECTION_UP then
        x = user:x() - 1.5 * TILESIZE
        y = user:y() - 2 * TILESIZE
        w = 3 * TILESIZE
        h = 2 * TILESIZE
        effect_id = 8
    elseif direction == DIRECTION_DOWN then
        x = user:x() - 1.5 * TILESIZE
        y = user:y()
        w = 3 * TILESIZE
        h = 2 * TILESIZE
        effect_id = 7
    elseif direction == DIRECTION_LEFT then
        x = user:x() - 2 * TILESIZE
        y = user:y() - 1.5 * TILESIZE
        w = 2 * TILESIZE
        h = 3 * TILESIZE
        effect_id = 9
    elseif direction == DIRECTION_RIGHT then
        x = user:x()
        y = user:y() - 1.5 * TILESIZE
        w = 2 * TILESIZE
        h = 3 * TILESIZE
        effect_id = 10
    end

    effect_create(effect_id, user:position())
    user:consume_ability(ability_id)

    local modded_damage = {
        base = damage.base * get_ability_factor(user, attribute_name),
        delta = damage.delta,
        chance_to_hit = damage.chance_to_hit,
    }

    for _, being in ipairs(get_beings_in_rectangle(x, y, w ,h)) do
        if being ~= user and (being:type() == TYPE_MONSTER or
           (map_get_pvp() == PVP_FREE and being:type() == TYPE_CHARACTER))
        then
            being:damage(modded_damage, user, attribute_name)
        end
    end
end)
