--[[

  Peter, working on the fields
  Home: House 5
  Relationships: -

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

local patrol = NPCPatrol:new("Peter")

local function man_talk(npc, ch)
    patrol:block(ch)

    say("Working on the fields is really hard. And with all the new taxes, "
        .. "we'll probably get even less pay.")
    patrol:unblock(ch)
end

local man = create_npc_by_name("Peter", man_talk)
man:set_base_attribute(16, 1)
patrol:assign_being(man)
schedule_every(21, function() patrol:logic() end)
