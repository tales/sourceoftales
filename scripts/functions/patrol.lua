--[[

  Script for grouping beings together and letting them patroul
  
  For creating a patrol choose a name. Then add objects to the map.
  The name of the object has to start with the name followed by a space
  and then the index number of the waypoint. The type of the object has to
  be set to WAYPOINT.
  
  Possible object parameters:
   + stroll    -> The radius in pixels that will allow the beings to stroll
                  is a being out of this radius it will walk to a random
                  position inside of it
   + tolerance -> The radius in pixels that tells whether a being reached a
                  waypoint. If all beings are within the tolerance radius
                  the next waypoint will be navigated.

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

-- ]]


Patrol = {}
local mt = {__index = Patrol}

local function manhattan_distance(x1, y1, x2, y2)
    return math.abs(x1 - x2) + math.abs(y1 - y2)
end

--- Creates a new patrol object
-- @param x X-starting coordinate
-- @param y Y-starting coordinate
-- @param stroll When letting beings walk this stroll is randomly applied to the
-- new coordinate
function Patrol:new(name)
    local objects = map_get_objects("WAYPOINT")
    local path = {}

    for _, object in ipairs(objects) do
        if string.starts(object:name(), name) then
            local id = tonumber(string.sub(object:name(), string.len(name) + 2))
            local stroll = tonumber(object:property("stroll") or 0)
            local tolerance = tonumber(object:property("tolerance") or stroll)
            local x, y, w, h = object:bounds()
            path[id] = {x=x + w / 2, y=y + h / 2, tolerance=tolerance, stroll=stroll}
        end
    end
    
    assert(#path >= 1, "Path \"" .. name .. "\" need to have at least one waypoint")

    return setmetatable({
        position_index = 1,
        path = path,
        members = {}
    }, mt)
end

--- Assigns a being to the patrol
-- NOTE: Make sure that you unassign this being manually if you remove it from
-- the map. Only usual death unassigns it automatically
-- @param being The being to assign
function Patrol:assign_being(being)
    table.insert(self.members, being)
    on_death(being, function() self:unassign_being(being) end)
end

--- Unassign a being from the patrol
-- @param being The being handle to unassign
function Patrol:unassign_being(being)
    for i, member in ipairs(self.members) do
        if member == being then
            table.remove(self.members, i)
            break
        end
    end
end

--- Calls the logic of the patrol
-- Will move the beings to a new point or will try to get all beings to the
-- current point
function Patrol:logic()
    local x = self.path[self.position_index].x
    local y = self.path[self.position_index].y
    local tolerance = self.path[self.position_index].tolerance
    local stroll = self.path[self.position_index].stroll
    local all_in_range = true
    for _, member in ipairs(self.members) do
        local dist = manhattan_distance(member:x(), member:y(), x, y)
        if dist > stroll then
            local new_x = math.random(-stroll, stroll) + x
            local new_y = math.random(-stroll, stroll) + y
            member:walk(new_x, new_y)
        end
        if dist > tolerance then
            all_in_range = false
        end
    end

    if all_in_range then
        -- Set next walkpoint as new target
        self.position_index = self.position_index + 1
        if self.position_index > #self.path then
            self.position_index = 1
        end
    end
end

--- Returns the index of the current waypoint
-- Use patrol.path to get the path table
function Patrol:get_currentWaypoint()
    return self.position_index
end

--- Stops the walking of all beings in the patrol
function Patrol:stop()
    for _, member in ipairs(self.members) do
        member:walk(member:position())
    end
end
