--[[

    Script for letting npcs walk defined routes

    To use create an npc and call:
      setWaypoints(npc, points, walkspeed, callback)
    being: being which should walk
    walkspeed: walkingspeed in tiles per second
    callback: function that should get called as soon the being reaches a point

--]]

local waypoints = {}

local function getWalkTime(being, x, y)
    local speed = being_get_modified_attribute(being, ATTR_MOVE_SPEED_TPS)
    local dist = get_distance(posX(being), posY(being),
                                   x, y) / TILESIZE
    return dist / speed
end

--- Setup the walking route of an npc.
-- The npc will walk along the given route, and restart from first waypoint after the last is reached.
-- @param npc The npc which should move along a route
-- @param points An array with tables as entries. One entry should have
--               x=integer in pixel coordinates, y=integer in pixel coordinates,
--               time=float in seconds, how long to wait upon arrival.
--               id=string this id will be additionally passed to callback
-- @param walkspeed The speed this npc should use
-- @param callback Function to be called when the next waypoint is reached.
--                 Easiest case would be 'function() gotoNextWaypoint(npc) end'
--                 to keep the npc walking to the next waypoint after arriving
--                 the current waypoint.

function setWaypoints(npc, points, walkspeed, callback)
    assert(npc ~= nil, "nil npc handle")
    assert(points ~= nil, "nil point table")
    waypoints[npc] = {}
    waypoints[npc].data = points
    waypoints[npc].currentIndex = 1
    waypoints[npc].callback = callback
    waypoints[npc].stoppedBy = {}
    being_set_base_attribute(npc, ATTR_MOVE_SPEED_TPS, walkspeed)
end

function gotoWaypoint(npc)
    local wp = waypoints[npc]

    being_walk(npc, wp.data[wp.currentIndex].x, wp.data[wp.currentIndex].y,
               being_get_modified_attribute(npc, ATTR_MOVE_SPEED_TPS))

    local addtime = 0
    if wp.data[wp.currentIndex].wait then
        addtime = wp.data[wp.currentIndex].wait
    end

    local time = addtime + getWalkTime(npc, wp.data[wp.currentIndex].x,
                                             wp.data[wp.currentIndex].y)

    schedule_in(time, function() walkingCallback(npc) end)
end

function gotoNextWaypoint(npc)
    assert(waypoints[npc] ~= nil, "nil npc handle")
    local wp = waypoints[npc]
    wp.currentIndex = (wp.currentIndex % #wp.data) + 1
    gotoWaypoint(npc)
end


--- Makes an npc stop walking on its route
--
-- @param npc Which npc should stop walking
-- @param ch optional character pointer. If a character is given multiple
--           pairs of stopWalking and continueWalking can be issues at
--           the same time. The npc will only continueWalking if all
--           characters have issued to continueWalking or have disconnected

function stopRoute(npc, ch)
    local wp = waypoints[npc]
    if ch then
        on_remove(ch, function() continueRoute(npc, ch) end)
        wp.stoppedBy[ch] = true
    end
    being_walk(npc, posX(npc), posY(npc))
end

--- Makes an npc continue walking
-- continues to walk on the predefined walking route.
--
-- @param npc Which npc should stop walking
-- @param ch optional character pointer. If a character is given multiple
--           pairs of stopWalking and continueWalking can be issues at
--           the same time. The npc will only continueWalking if all
--           characters have issued to continueWalking or have disconnected
function continueRoute(npc, ch)
    assert(waypoints[npc] ~= nil, "nil npc handle")
    local wp = waypoints[npc]

    if ch then
        wp.stoppedBy[ch] = nil
        if next(wp.stoppedBy) then
            return
        end
    end

    gotoWaypoint(npc)
end


--- Internal callback when the npc should have arrived at its destination.
-- checks if the npc is really there, if not just try again to walk to the right place.
-- This also handles the user callback
function walkingCallback(npc)
    local wp = waypoints[npc]
    -- In case the npc is being talked to at the moment, we will drop,
    -- this current callback, since it will be rescheduled again after talking is finished.
    if not next(wp.stoppedBy) then
        if wp.data[wp.currentIndex].x == posX(npc) and wp.data[wp.currentIndex].y == posY(npc) then
            -- check if the npc already reched the waypoint.
            -- This may be not the case, if the npc was hindered by players to walk there.
            wp.callback(npc, wp.data[wp.currentIndex].id)
        else
            -- if the  npc is not there, just try again to walk to the destination.
            gotoWaypoint(npc)
        end
    end
end
