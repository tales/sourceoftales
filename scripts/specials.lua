--[[

 Special action script file

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

function recalculate_special_rechargespeed(user, special)
    local speed = 175 + user:base_attribute(ATTR_INT)
    user:set_special_recharge_speed(special, speed)
end

function get_special_factor(user, skill_name)
    local exp = user:xp(skill_name)
    local factor = math.max(user:level(skill_name) / 10, 1)
    return factor * (user:base_attribute(ATTR_WIL) / 128 + 1)
end

require "scripts/specials/firelion"
require "scripts/specials/earthquake"
require "scripts/specials/lightning"
require "scripts/specials/heal"
require "scripts/specials/snakebite"
require "scripts/specials/insult"
