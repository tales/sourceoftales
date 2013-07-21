--[[

  Logic of traps

  To create a trap place a trap object on the map and require this file in your
  atinit function.

  The mapobject has to have the following properties:
   TYPE             -> "TRAP"
   damage           -> value of damage
   damage_delta     -> delta of damage. default: 0
   chance_to_hit    -> chance to hit. default: 999
   reuse_delay      -> time until the trap can get triggered again after use. default: 0
   trigger_radius   -> radius around the trap in which a trigger is placed. default: 0
   trigger_delay    -> time in seconds until trap deals damage. default: 0
   effect_id        -> effect that will be spawned in the center of the trap. default: none

  As soon someone steps on the trigger surrounding the trap the trigger_delay
  is scheduled. If the timer is up damage will be dealt to all beings in the
  focus of the trap (boundaries of the object in tiled)

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

module("trap", package.seeall)

local traps = {}


--- Assigns a callback to the trap trigger. If the callback returns true no
-- damage is dealt
-- @param name The name of the trap (the name property of the object in tiled)
-- @param func The function that will be called with the being as parameter
function assign_callback(name, func)
    for _, trap in ipairs(traps[get_map_id()]) do
        if trap.name == name then
            trap.callback = func
            break
        end
    end
end

local function deal_damage(trap)
    local beings = get_beings_in_rectangle(trap.x, trap.y, trap.w, trap.h)
    for _, being in ipairs(beings) do
        being:damage(trap.damage)
    end
    trap.usable = false
    schedule_in(trap.reuse_delay, function() trap.usable = true end)
end

local function triggered(trap, being)
    if not trap.usable then
        return
    end

    if trap.callback and trap.callback(being) then
        return
    end

    if trap.effect_id ~= -1 then
        effect_create(trap.effect_id, trap.x + trap.w / 2, trap.y + trap.h / 2)
    end

    schedule_in(trap.trigger_delay, function() deal_damage(trap) end)
end

function parse_traps_from_map()
    local objects = map_get_objects("TRAP")
    for _, object in ipairs(objects) do
        traps[get_map_id()] = traps[get_map_id()] or {}

        local trap = {}
        trap.name = object:name()
        trap.damage = {}
        trap.damage.base = tonumber(object:property("damage"))
        trap.damage.delta = tonumber(object:property("damage_delta") or 0)
        trap.damage.chance_to_hit = tonumber(object:property("chance_to_hit") or 999)
        trap.effect_id = tonumber(object:property("effect_id") or -1)
        trap.reuse_delay = tonumber(object:property("reuse_delay") or 0)
        trap.trigger_delay = tonumber(object:property("trigger_delay") or 0)
        trap.usable = true
        local trigger_radius = tonumber(object:property("trigger_radius") or 0)
        trap.x, trap.y, trap.w, trap.h = object:bounds()
        local new_id = #traps[get_map_id()] + 1
        trigger_create(trap.x - trigger_radius, trap.y - trigger_radius,
                    2 * trigger_radius + trap.w, 2 * trigger_radius + trap.h,
                    function(being, id) triggered(trap, being) end, 0, true)

        traps[get_map_id()][new_id] = trap
    end
end

