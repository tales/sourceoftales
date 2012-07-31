--[[

  The starting map.

  Copyright (C) 2012 Jessica Tölke
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

atinit(function()
    require "scripts/functions/npchelper"
    require "scripts/functions/triggerhelper"
    parse_npcs_from_map()
    parse_triggers_from_map()

    require "scripts/functions/guardpatrol"
    require "scripts/functions/rebelpatrol"
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
    local rebelpatrol1 = RebelPatrol:new("Patrol1_Rebels", 5 * TILESIZE, REPUTATION_ONTRIAL)
    for i=1,10 do
         rebelpatrol1:assignBeing(monster_create(11, get_named_coordinate("Patrol1_Rebels_Spawn")))
    end
    schedule_every(1, function() rebelpatrol1:logic() end)
end)
