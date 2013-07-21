--[[

 Special action script file

  Copyright (C) 2012-2013 Erik Schilling

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

function Entity:consume_ability(ability)
    local speed = 175 + self:base_attribute("Intelligence")
    self:set_ability_cooldown(ability, 17500 / speed)
end

function get_ability_factor(user, attribute_name)
    local exp = user:xp(attribute_name)
    local factor = math.max(user:base_attribute(attribute_name) / 10, 1)
    return factor * (user:base_attribute("Willpower") / 128 + 1)
end

require "scripts/abilities/firelion"
require "scripts/abilities/earthquake"
require "scripts/abilities/lightning"
require "scripts/abilities/heal"
require "scripts/abilities/snakebite"
require "scripts/abilities/strike"
require "scripts/abilities/insult"
