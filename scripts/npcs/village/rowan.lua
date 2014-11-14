--[[

  Fisherman Rowan
  Home: House 1
  Relationships: Husband of Basilea

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

local patrol = NPCPatrol:new("Rowan")

local function man_talk(npc, ch)
    patrol:block(ch)

    say("Tight Lines! Today was a good day, I caught quite a lot of fishes.")
    say("I think I'll be over to the inn later, drink a beer and have a nice "
        .. "chat with Norman.")
    patrol:unblock(ch)
end

local man = create_npc_by_name("Rowan", man_talk)
man:set_base_attribute(16, 1)
patrol:assign_being(man)
schedule_every(8, function() patrol:logic() end)
