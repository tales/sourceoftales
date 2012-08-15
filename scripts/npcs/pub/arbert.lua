--[[

  Arbert

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

local patrol = NPCPatrol:new("Arbert")

local function man_talk(npc, ch)
    patrol:block(ch)
    local function say(message)
        npc_message(npc, ch, message)
    end

    say("Do you see Borin over there? He's always drunk...")
    say("One day, he was so drunk that he fell into the pond "
        .. "in front of the pub's entrance when he left.")
    say("That was funny, I tell you! Well, he nearly drowned, "
        .. "but Norman was able to pull him out soon enough.")
    patrol:unblock(ch)
end

local man = create_npc_by_name("Arbert", man_talk)
being_set_base_attribute(man, 16, 1)
patrol:assign_being(man)
schedule_every(17, function() patrol:logic() end)
