--[[

  This script reads all npcs from the map and provides functions to get their
  coordinates. It has its own create_npc function to make creating npcs a bit
  easier.

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

local npcs = {}

local function get_gender_by_string(v)
    if v == "male" then
        return GENDER_MALE
    elseif v == "female" then
        return GENDER_FEMALE
    else
        return GENDER_UNSPECIFIED
    end
end

function parse_npcs_from_map()
    npcs[get_map_id()] = {}
    local map_objects = map_get_objects("NPC_POSITION")
    for _, object in ipairs(map_objects) do
        local x, y, w, h = object:bounds()
        npcs[get_map_id()][object:name()] = {
            x = x + w / 2,
            y = y + h / 2,
            sprite_id = tonumber(object:property("sprite_id")),
            gender = get_gender_by_string(object:property("gender"))
        }
    end
end

function create_npc_by_name(name, talk_func, update_func)
    local npc = npcs[get_map_id()][name]
    assert(npc ~= nil, "NPC with name \"" .. name ..
           "\" not defined on map " .. get_map_id())
    return npc_create(name, npc.sprite_id, npc.gender, npc.x, npc.y,
                      talk_func, update_func)
end
