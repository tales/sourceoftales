--[[

  Recruit Alan

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

local function recruit_talk(npc, ch)
    local function say(message)
        npc_message(npc, ch, message)
    end
    say("Ah, I'm bored. There wasn't much going on since I arrived here. "
        .. "I hope those rebels will stir some trouble, "
        .. "a decent fight would be fun by now.")
end

local recruit = create_npc_by_name("Recruit Alan", recruit_talk)

being_set_base_attribute(recruit, 16, 2)
local patrol = Patrol:new("Recruit Alan")
patrol:assign_being(recruit)
schedule_every(5, function() patrol:logic() end)
