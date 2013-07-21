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
local attribute_name = "Magic/Snake Bite"
local damage = {
    base = 40,
    delta = 5,
    chance_to_hit = 20,
}
local range = 6 * TILESIZE

-- offset of the snake relative to target
local offset = TILESIZE

local spell = get_ability_info("Magic/Snake Bite")
spell:on_use(function(user, target, ability_id)
    if not target or not (target:type() == TYPE_MONSTER or
        (map_get_pvp() == PVP_FREE and target:type() == TYPE_CHARACTER))
    then
        return
    end

    user:consume_ability(ability_id)

    -- Get direction
    local d_x = target:x() - user:x()
    local d_y = target:y() - user:y()
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

    effect_create(effect_id, target:position())

    local modded_damage = {
        base = damage.base * get_ability_factor(user, attribute_name),
        delta = damage.delta,
        chance_to_hit = damage.chance_to_hit,
    }

    target:damage(modded_damage, user, attribute_name)
end)
