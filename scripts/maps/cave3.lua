--[[

  A cave with a lot of scripted monster spawns

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

local mobs = {
    "Skeleton",
    "Skeleton",
    "Skeleton Soldier",
    "Skeleton Soldier",
    "Skeleton Mage"
}

local current_skeletons = {}

local function spawn(being, name, amount)
    if being:type() ~= TYPE_CHARACTER then return end

    current_skeletons[name] = current_skeletons[name] or {}
    local list = current_skeletons[name]

    if next(list) ~= nil then return end

    local x, y = get_named_coordinate(name)

    amount = amount or 4

    for i = 1, amount do
        local mob = monster_create(mobs[math.random(#mobs)],
                       x + math.random(-2 * TILESIZE, 2 * TILESIZE),
                       y + math.random(-2 * TILESIZE, 2 * TILESIZE))
        list[mob] = 0
        on_death(mob, function() list[mob] = nil end)
    end
end

local function cleanup()
    for _, list in pairs(current_skeletons) do
        for mob, lifetime in pairs(list) do
            if #mob:angerlist() == 0 then
                if lifetime == 1 then
                    mob:set_base_attribute(13, 0)
                    list[mob] = nil
                else
                    list[mob] = 1
                end
            end
        end
    end
end

atinit(function()
    require "scripts/functions/triggerhelper"
    require "scripts/functions/trap"
    
    require "scripts/monsters/skeleton_boss"

    parse_triggers_from_map()
    trap.parse_traps_from_map()

    create_trigger_by_name("spawn_trigger_up_left_left",
        function(being) spawn(being, "spawn_up_left_left") end)
    create_trigger_by_name("spawn_trigger_up_left",
        function(being) spawn(being, "spawn_up_left") end)
    create_trigger_by_name("spawn_trigger_up_middle",
        function(being) spawn(being, "spawn_up_middle") end)
    create_trigger_by_name("spawn_trigger_up_right",
        function(being) spawn(being, "spawn_up_right") end)
    create_trigger_by_name("spawn_trigger_up_right_right",
        function(being) spawn(being, "spawn_up_right_right") end)

    create_trigger_by_name("spawn_trigger_lower_middle",
        function(being) spawn(being, "spawn_lower_middle", 7) end)
    
    schedule_every(60, function() cleanup() end)
end)

