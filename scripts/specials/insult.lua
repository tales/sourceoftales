--[[

  Script file of the insult spell

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
local skill_name = "Magic_Insult"
local range = 5 * TILESIZE
local anger = 50

local spell = get_special_info("Magic_Insult")
spell:on_use(function(user, target, special_id)
    local anger_mod = anger * get_special_factor(user, skill_name)

    chr_set_special_mana(user, special_id, 0)
    recalculate_special_rechargespeed(user, special_id)

    local beings = get_beings_in_circle(user, range)
    for _, being in ipairs(beings) do
        if being_type(being) == TYPE_MONSTER then
            monster_change_anger(being, user, anger_mod)
        end
    end
end)
