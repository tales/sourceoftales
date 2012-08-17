--[[

  Inside Casern Storage (Smith Blackwin's workshop)

  Copyright (C) 2012 Philippe Groarke

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

local soldier_guy_patrol = Soldier_patrol:new("SoldierPatrol", 4 * TILESIZE,
                                              REPUTATION_RELUCTANT)
schedule_every(1, function() soldier_guy_patrol:logic() end)
local key_spawned = false
local soldier_spawned = false

local function die()
    map["storage_daggers_soldier_guy"] = "0"
end

local function spawn(patrol, mob)
    local x = patrol.path[patrol.position_index].x
    local y = patrol.path[patrol.position_index].y
    local soldier_guy = monster_create(mob, x, y)
    on_death(soldier_guy, die())
    patrol:assign_being(soldier_guy)

end

local function rebelphilip_daggers(being, id)
    if being_type(being) ~= TYPE_CHARACTER then
        return
    end

    local quest = chr_try_get_quest(being, "rebelphilip_daggers")
    if quest == "started" then
        if key_spawned == false then
            item_drop(80, 144, "Cellar Key")
            key_spawned = true
        end

        if (map["storage_daggers_soldier_guy"] == "0"
            or map["storage_daggers_soldier_guy"] == "")
           and soldier_spawned == false
        then
            map["storage_daggers_soldier_guy"] = "1"
            soldier_spawned = true
            spawn(soldier_guy_patrol, "Soldier")

        elseif map["storage_daggers_soldier_guy"] == "1" then
            spawn(soldier_guy_patrol, "Soldier")

        --elseif soldier_spawned == true and map["storage_daggers_soldier_guy"] == "0" then
            --return
        end
    end
end

atinit(function()
    require "scripts/functions/triggerhelper"
    require "scripts/functions/guardpatrol"
    require "scripts/functions/soldierpatrol"

    parse_triggers_from_map()
    create_trigger_by_name("rebelphilip daggers quest", rebelphilip_daggers)
    end)