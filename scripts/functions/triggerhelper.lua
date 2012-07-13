-- [[
-- This script reads all triggers from the map and provides functions to 
-- create them by name.
--
-- Authors:
-- - Ablu
-- ]]

local triggers = {}

local function getBoolByString(v)
    if v == "true" then
        return true
    elseif v == "false" then
        return false
    else
        return nil
    end
end

local function init()
    local map_objects = map_get_objects("TRIGGER")
    for _, object in ipairs(map_objects) do
        local x, y, w, h = object:bounds()
        triggers[object:name()] = {
            x = x,
            y = y,
            w = w,
            h = h,
            id = tonumber(object:property("id") or 0),
            once = getBoolByString(object:property("once")) or false
        }
    end
end

function create_trigger_by_name(name, trigger_func)
    local trigger = triggers[name]
    trigger_create(trigger.x, trigger.y, trigger.w, trigger.h,
                   trigger_func, trigger.id, trigger.once)
end

init()
