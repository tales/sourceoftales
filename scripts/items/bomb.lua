--[[

  Bomb script that spawns a bomb that explodes after some time and deals damage

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

local damage = {
    base = 30,
    delta = 10,
    chance_to_hit = 200,
}
local skillname = "Weapons_Bombing"
local effect_id = 6
local delay = 2
local range = 3 * TILESIZE
local function get_skill_factor(skill_exp)
    return math.max(1, math.log(skill_exp))
end

get_item_class(7):on("use", function(user)
    -- Assign on remove callback to prevent server crashs
    on_remove(user, function() user = nil end)

    local x, y = user:position()
    local exp = user:xp(skillname)
    local damage_mod = get_skill_factor(exp) * damage


    schedule_in(delay, function()
        if not user then WARN("STOP"); return end

        local beings = get_beings_in_rectangle(x - range, y - range,
                                               2 * range, 2 * range)
        effect_create(effect_id, x, y)
        for _, being in ipairs(beings) do
            if being:type() == TYPE_MONSTER or being == user or
               (map_get_pvp() == PVP_FREE and being:type() == TYPE_CHARACTER) then
                WARN("DAMAGE")

                being:damage(damage_mod, damage_delta, accuracy,
                             DAMAGE_PHYSICAL, ELEMENT_EARTH, user, skillname)
            end
        end
    end)
end)
