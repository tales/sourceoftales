--[[

  Millicent
  Home: House 6
  Relationships: Wife of Borin

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

local patrol = NPCPatrol:new("Millicent")

local function woman_talk(npc, ch)
    patrol:block(ch)

    say("Have you seen my husband Borin? I bet he's in the pub again...")
    say("I work all day, and he has nothing better to do than taking our "
        .. "money and spend it on getting drunk.")
    patrol:unblock(ch)
end

local woman = create_npc_by_name("Millicent", woman_talk)
woman:set_base_attribute(16, 1)
patrol:assign_being(woman)
schedule_every(11, function() patrol:logic() end)
