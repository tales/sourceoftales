--[[

    Cellar of the casern.

  Copyright (C) 2012 Felix Stadthaus
  Copyright (C) 2014 Jessica Beller

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
    parse_npcs_from_map()

    require "scripts/functions/guardpatrol"
    require "scripts/functions/soldierpatrol"

    require "scripts/npcs/casern_cellar/guarddain"
    require "scripts/npcs/casern_cellar/prisonerasher"
    require "scripts/npcs/casern_cellar/prisonerberta"
    require "scripts/npcs/casern_cellar/prisonerdavid"
    require "scripts/npcs/casern_cellar/prisonergamel"
    require "scripts/npcs/casern_cellar/prisonergavin"
    require "scripts/npcs/casern_cellar/prisonerhaunild"
    require "scripts/npcs/casern_cellar/prisonersaer"

-- Soldier patrols
    local soldierpatrol = Soldier_patrol:new("SoldierPatrol", 10 * TILESIZE, REPUTATION_RELUCTANT)
    schedule_every(1, function() soldierpatrol:logic() end)

    local function respawn(patrol, mob, amount)
        local x = patrol.path[patrol.position_index].x
        local y = patrol.path[patrol.position_index].y
        for i=1, amount do
            patrol:assign_being(monster_create(mob, x, y))
        end
    end

    schedule_every(60, function()
        if #soldierpatrol.members == 0 then
            schedule_in(30, function() respawn(soldierpatrol, "Soldier", 4) end)
        end
    end)
end)
