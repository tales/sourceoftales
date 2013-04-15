--[[

  A map for testing features. This map is not accessible in game

  Copyright (C) 2012 Erik Schilling
  Copyright (C) 2012 jurkan

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

require "scripts/functions/rebelpatrol"

atinit(function()
    trap.parse_traps_from_map()

    local mob_id = 4
    local patrol = Rebel_patrol:new("Patrol test", 5 * TILESIZE, REPUTATION_ONTRIAL)
    for i=1,10 do
        patrol:assign_being(monster_create(mob_id, get_named_coordinate("patrolspawn")))
    end
    schedule_every(1, function() patrol:logic() end)

    require "scripts/functions/trap"
    trap.assign_callback("trap", function(being) being:say("I stepped on a TRAP!") end)
end)

