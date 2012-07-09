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

function Patrol:new(x, y)
    return setmetatable({
        position_index = 1,
        path = { {x=x, y=y} },
        members = {}
    }, mt)
end

function Patrol:addWayPoint(x, y)
    table.insert(self.path, {x=x, y=y})
end

function Patrol:assignBeing(being)
    table.insert(self.members, being)
    on_death(being, function() self:unassignBeing(being) end)
end

function Patrol:unassignBeing(being)
    for i, member in ipairs(self.members) do
        if member == being then
            table.remove(self.members, i)
            break
        end
    end
end

function Patrol:logic()
    local x = self.path[self.position_index].x
    local y = self.path[self.position_index].y
    local all_in_range = true
    for _, member in ipairs(self.members) do
        if manhattan_distance(posX(member), posY(member), x, y) > 5 * TILESIZE then
            being_walk(member, x, y)
            all_in_range = false
        end
    end

    if all_in_range then
        -- Set next walkpoint as new target
        self.position_index = ((self.position_index + 1) % #self.path) +1
    end
end

function Patrol:getCurrentWaypoint()
    return self.position_index
end
