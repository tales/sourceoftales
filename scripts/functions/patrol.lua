-- [[
-- Script for grouping beings together and letting them patroul
--
-- Authors:
-- - Ablu
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
function Patrol:new(x, y, stroll)
    return setmetatable({
        position_index = 1,
        path = { {x=x, y=y} },
        members = {},
        stroll = stroll
    }, mt)
end

--- Adds a new waypoint to the patrol
-- Make sure that the point is not too far away from the last one since the
-- pathfinding only works over a few tiles
-- @param x X-Coordinate of the point
-- @param y Y-Coordinate of the point
function Patrol:addWayPoint(x, y)
    table.insert(self.path, {x=x, y=y})
end

--- Assigns a being to the patrol
-- NOTE: Make sure that you unassign this being manually if you remove it from
-- the map. Only usual death unassigns it automatically
-- @param being The being to assign
function Patrol:assignBeing(being)
    table.insert(self.members, being)
    on_death(being, function() self:unassignBeing(being) end)
end

--- Unassign a being from the patrol
-- @param being The being handle to unassign
function Patrol:unassignBeing(being)
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
    local all_in_range = true
    for _, member in ipairs(self.members) do
        if manhattan_distance(posX(member), posY(member), x, y) > 5 * TILESIZE then
            being_walk(member, x + math.random(-self.stroll, self.stroll),
                       y + math.random(-self.stroll, self.stroll))
            all_in_range = false
        end
    end

    if all_in_range then
        -- Set next walkpoint as new target
        self.position_index = ((self.position_index + 1) % #self.path) +1
    end
end

--- Returns the index of the current waypoint
-- Use patrol.path to get the path table
-- @param x X-Coordinate of the point
function Patrol:getCurrentWaypoint()
    return self.position_index
end
