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
    local speed = 175 + being_get_base_attribute(user, ATTR_INT)
    chr_set_special_recharge_speed(user, special, speed)
end

function get_special_factor(user, skill_name)
    local exp = chr_get_exp(user, skill_name)
    local factor = math.max(chr_get_level(user, skill_name) / 10, 1)
    return factor * (being_get_base_attribute(user, ATTR_WIL) / 128 + 1)
end

require "scripts/specials/firelion"
require "scripts/specials/earthquake"
require "scripts/specials/lightning"
require "scripts/specials/heal"
require "scripts/specials/snakebite"
require "scripts/specials/insult"
