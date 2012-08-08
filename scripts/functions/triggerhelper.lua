--[[

  This script reads all triggers from the map and provides functions to 
  create them by name.

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

local triggers = {}

local function get_boolBy_string(v)
    if v == "true" then
        return true
    elseif v == "false" then
        return false
    else
        return nil
    end
end

function parse_triggers_from_map()
    triggers[get_map_id()] = {}
    local map_objects = map_get_objects("TRIGGER")
    for _, object in ipairs(map_objects) do
        local x, y, w, h = object:bounds()
        triggers[get_map_id()][object:name()] = {
            x = x,
            y = y,
            w = w,
            h = h,
            id = tonumber(object:property("id") or 0),
            once = get_boolBy_string(object:property("once")) or true
        }
    end
end

function create_trigger_by_name(name, trigger_func)
    local trigger = triggers[get_map_id()][name]
    assert(trigger ~= nil, "The trigger \"" .. name .. "\" is not defined on map " .. get_map_id())
    trigger_create(trigger.x, trigger.y, trigger.w, trigger.h,
                   trigger_func, trigger.id, trigger.once)
end
