-- [[
-- This script reads all npcs from the map and provides functions to get their
-- coordinates. It has its own create_npc function to make creating npcs a bit
-- easier.
--
-- Authors:
-- - Ablu
-- ]]

local npcs = {}

local function getGenderByString(v)
    if v == "male" then
        return GENDER_MALE
    elseif v == "female" then
        return GENDER_FEMALE
    else
        return GENDER_UNSPECIFIED
    end
end

local function init()
    local map_objects = map_get_objects("NPC_POSITION")
    for _, object in ipairs(map_objects) do
        local x, y, w, h = object:bounds()
        npcs[object:name()] = {
            x = x + w / 2,
            y = y + h / 2,
            sprite_id = tonumber(object:property("sprite_id")),
            gender = getGenderByString(object:property("gender"))
        }
    end
end

function create_npc_by_name(name, talk_func, update_func)
    local npc = npcs[name]
    assert(npc ~= nil, "NPC with name \"" .. name ..
           "\" not defined on map " .. get_map_id())
    return npc_create(name, npc.sprite_id, npc.gender, npc.x, npc.y,
                      talk_func, update_func)
end

init()
