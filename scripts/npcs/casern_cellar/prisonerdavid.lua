--[[

  Prisoner David

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

local patrol = NPCPatrol:new("Prisoner David")

local function prisoner_talk(npc, ch)
    say("...")
end

local prisoner = patrol:create_npc(prisoner_talk)
prisoner:set_base_attribute(16, 2)

schedule_every(3, function() patrol:logic() end)
