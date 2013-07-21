--[[

  Definition of the normal player strike attack

  Copyright (C) 2013 Erik Schilling

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

-- Constants related to the ability
local range = 20 * TILESIZE

local ability = get_ability_info("Strike")
ability:on_use(function(user, x, y, ability_id)
    user:set_ability_cooldown(ability_id, 5)

    local beings = get_beings_in_circle(x, y, range)
    for _, being in ipairs(beings) do
        if being ~= user and (being:type() == TYPE_MONSTER or
           (map_get_pvp() == PVP_FREE and being:type() == TYPE_CHARACTER))
        then
            local damage = {
                base = user:modified_attribute("Damage"),
                delta = user:modified_attribute("Damage Delta"),
                chance_to_hit = user:modified_attribute("Hit chance"),
            }
            being:damage(damage, user, attribute_name)
        end
    end
end)
