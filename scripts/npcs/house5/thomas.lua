--[[

  Thomas
  Home: House 5
  Relationships: -

  Copyright (C) 2012 Jessica Tölke
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

local patrol = NPCPatrol:new("Thomas")

local function man_talk(npc, ch)
    patrol:block(ch)
    say("Hello. Here are the farmworker's quarters. Most of us live here "
        .. "for the summer to help out with the field work, and then "
        .. "travel to other place where we can find other work.")
    patrol:unblock(ch)
end

local man = create_npc_by_name("Thomas", man_talk)

man:set_base_attribute(16, 1)
patrol:assign_being(man)
schedule_every(14, function() patrol:logic() end)

