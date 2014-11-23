--[[

  Libary for handling soldier patrols

  Copyright (C) 2012 Erik Schilling
  Copyright (C) 2012 Felix Stadthaus

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

require "scripts/functions/guardpatrol"
require "scripts/functions/reputation"

Soldier_patrol = {}
setmetatable(Soldier_patrol, {__index=Guard_patrol})
local mt = {__index=Soldier_patrol}

function Soldier_patrol:new(name, track_range, min_reputation)
    local patrol = Guard_patrol:new(name, track_range)
    setmetatable(patrol, mt)
    patrol.min_reputation = min_reputation
    return patrol
end

function Soldier_patrol:is_aggressiveAgainst(being)
    if not (being:type() == TYPE_CHARACTER and
            being:base_attribute(13) > 0) then
        return false
    end

    local reputation = being:reputation("Soldier reputation")
    if reputation < self.min_reputation then
        return true
    end
    return false
end
