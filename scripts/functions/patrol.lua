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
function Patrol:new(name)
    local objects = map_get_objects("WAYPOINT")
    local path = {}

    for _, object in ipairs(objects) do
        WARN("CHECKING \"" .. object:name() .. "\" vs \"" .. name .. "\"")
        if string.starts(object:name(), name) then
            local id = tonumber(string.sub(object:name(), string.len(name) + 2))
            local stroll = tonumber(object:property("stroll") or 0)
            local tolerance = tonumber(object:property("tolerance") or stroll)
            local x, y, w, h = object:bounds()
            path[id] = {x=x + w / 2, y=y + h / 2, tolerance=tolerance, stroll=stroll}
            WARN("ADDED " .. id)
        end
    end
    
    assert(#path >= 1, "Path need to have at least one waypoint")

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
    WARN("LOGIC")
    local x = self.path[self.position_index].x
    local y = self.path[self.position_index].y
    local tolerance = self.path[self.position_index].tolerance
    local stroll = self.path[self.position_index].stroll
    WARN("x: " .. x .. ", y: " .. y .. ", i: " .. self.position_index .. ", l: " .. #self.path)
    local all_in_range = true
    for _, member in ipairs(self.members) do
        local dist = manhattan_distance(posX(member), posY(member), x, y)
        if dist > stroll then
            local new_x = math.random(-stroll, stroll) + x
            local new_y = math.random(-stroll, stroll) + y
            being_walk(member, new_x, new_y)
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
        WARN("NEXT")
    end
end

--- Returns the index of the current waypoint
-- Use patrol.path to get the path table
function Patrol:getCurrentWaypoint()
    return self.position_index
end

--- Stops the walking of all beings in the patrol
function Patrol:stop()
    for _, member in ipairs(self.members) do
        being_walk(member, posX(member), posY(member))
    end
end
