--[[

  Libary for handling guard patrols

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

require "scripts/functions/patrol"

Guard_patrol = {}
setmetatable(Guard_patrol, {__index=Patrol})
local mt = {__index=Guard_patrol}

function Guard_patrol:new(name, track_range)
    local patrol = Patrol:new(name)
    setmetatable(patrol, mt)
    patrol.track_range = track_range
    return patrol
end

function Guard_patrol:set_trackRange(radius)
    self.track_range = radius
end

function Guard_patrol:logic()
    local x = self.path[self.position_index].x
    local y = self.path[self.position_index].y
    local all_in_range = true

    local enemies = {}
    local beings = get_beings_in_rectangle(x - self.track_range,
                                           y - self.track_range,
                                           self.track_range * 2,
                                           self.track_range * 2)

    for _, being in ipairs(beings) do
        if self:is_aggressiveAgainst(being) then
            table.insert(enemies, being)
        end
    end

    local enemy_count = 0

    for _, member in ipairs(self.members) do
        -- Check for out of range enemies
        local anger_list = member:angerlist()
        enemy_count = enemy_count + #anger_list
        for ch, anger in pairs(anger_list) do
            if get_distance(ch:x(), ch:y(), x, y) > self.track_range * 2 then
                member:drop_anger(ch)
                enemy_count = enemy_count - 1
            end
        end

        for _, enemy in ipairs(enemies) do
            member:change_anger(enemy, 1)
        end
    end

    -- No enemies, handle walkcycle
    if enemy_count == 0 then
        Patrol.logic(self)
        return
    end
end

function Guard_patrol:is_aggressiveAgainst(being)
    return being:type() == TYPE_CHARACTER and
           being:base_attribute(13) > 0
end
