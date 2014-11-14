--[[

  Thea
  Home: House 7
  Relationships: Sister of Eva, mother of Emma

  Copyright (C) 2012 Jessica Tölke

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

local patrol = NPCPatrol:new("Thea")

local function woman_talk(npc, ch)
    patrol:block(ch)

    say("I'm really worried about all these boys out there in the forest.")
    say("Fighting against the king is a rather serious thing. "
        .. "I wonder if they're aware what danger they put themselves into.")
    patrol:unblock(ch)
end

local woman = create_npc_by_name("Thea", woman_talk)

woman:set_base_attribute(16, 2)
patrol:assign_being(woman)
schedule_every(3, function() patrol:logic() end)

