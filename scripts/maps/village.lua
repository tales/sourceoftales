--[[

  The starting map.

  Copyright (C) 2012 Jessica Tölke
  Copyright (C) 2012 Erik Schilling
  Copyright (C) 2012 Felix Stadthaus

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

atinit(function()
    require "scripts/functions/npchelper"
    require "scripts/functions/triggerhelper"
    parse_npcs_from_map()
    parse_triggers_from_map()

    require "scripts/functions/guardpatrol"
    require "scripts/functions/rebelpatrol"
    require "scripts/functions/soldierpatrol"
    require "scripts/functions/npcpatrol"

    -- Inside of casern
    require "scripts/npcs/village/guardfordwin"
    require "scripts/npcs/village/guardterric"
    require "scripts/npcs/village/instructoralard"
    require "scripts/npcs/village/recruithugh"
    require "scripts/npcs/village/recruitmaurice"
    require "scripts/npcs/village/smithblacwin"
    require "scripts/npcs/village/veterangodwin"

    -- People in front of casern
    require "scripts/npcs/village/emma"
    require "scripts/npcs/village/merchantanabel"
    require "scripts/npcs/village/merchantgilbert"
    require "scripts/npcs/village/merchantwalter"
    require "scripts/npcs/village/monkmartin"

    --Rebels in the forest
    require "scripts/npcs/village/rebeldamien"
    require "scripts/npcs/village/rebelhenry"
    require "scripts/npcs/village/rebelphilip"
    require "scripts/npcs/village/rebeltristan"

    -- Shrine
    require "scripts/npcs/village/priestesslinota"

    -- Village
    require "scripts/npcs/village/basilea"
    require "scripts/npcs/village/durmark"
    require "scripts/npcs/village/eva"
    require "scripts/npcs/village/francis"
    require "scripts/npcs/village/joseph"
    require "scripts/npcs/village/mary"
    require "scripts/npcs/village/millicent"
    require "scripts/npcs/village/oliver"
    require "scripts/npcs/village/peter"
    require "scripts/npcs/village/rowan"
    require "scripts/npcs/village/thea"

    -- Rebel patrols
    local rebelpatrol1 = Rebel_patrol:new("Patrol1_Rebels", 10 * TILESIZE, REPUTATION_RELUCTANT)
    local rebelpatrol2 = Rebel_patrol:new("Patrol2_Rebels", 10 * TILESIZE, REPUTATION_RELUCTANT)
    schedule_every(1, function() rebelpatrol1:logic() end)
    schedule_every(2, function() rebelpatrol2:logic() end)

    -- Soldier patrols
    local soldierpatrol1 = Soldier_patrol:new("Patrol1_Soldiers", 10 * TILESIZE, REPUTATION_RELUCTANT)
    local soldierpatrol2 = Soldier_patrol:new("Patrol2_Soldiers", 10 * TILESIZE, REPUTATION_RELUCTANT)
    schedule_every(1, function() soldierpatrol1:logic() end)
    schedule_every(2, function() soldierpatrol2:logic() end)

    local function respawn(patrol, mob, amount)
        local x = patrol.path[patrol.position_index].x
        local y = patrol.path[patrol.position_index].y
        for i=1, amount do
            patrol:assign_being(monster_create(mob, x, y))
        end
    end

    schedule_every(60, function()
        if #rebelpatrol1.members == 0 then
            schedule_in(30, function() respawn(rebelpatrol1, "Rebel", 4) end)
        end
        if #rebelpatrol2.members == 0 then
            schedule_in(30, function() respawn(rebelpatrol2, "Rebel", 4) end)
        end
        if #soldierpatrol1.members == 0 then
            schedule_in(30, function() respawn(soldierpatrol1, "Soldier", 5) end)
        end
        if #soldierpatrol2.members == 0 then
            schedule_in(30, function() respawn(soldierpatrol2, "Soldier", 5) end)
        end
    end)
end)
