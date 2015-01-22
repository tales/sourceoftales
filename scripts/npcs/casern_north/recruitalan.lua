--[[

  Recruit Alan

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

local patrol = NPCPatrol:new("Recruit Alan")

local function recruit_talk(npc, ch)
    patrol:block(ch)
    say("Ah, I'm bored. There wasn't much going on since I arrived here. "
        .. "I hope those rebels will stir some trouble, "
        .. "a decent fight would be fun by now.")
    patrol:unblock(ch)
end

local recruit = create_npc_by_name("Recruit Alan", recruit_talk)

recruit:set_base_attribute(16, 2)
patrol:assign_being(recruit)
schedule_every(5, function() patrol:logic() end)
