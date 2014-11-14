--[[

  Eva - gossiping on the market place
  Home: House 7
  Relationships: Sister of Thea, aunt of Emma

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

local patrol = NPCPatrol:new("Eva")

local function woman_talk(npc, ch)
    patrol:block(ch)

    say("Did you see Anabel in front of the casern? And her husband Walter?")
    say("Since so many soldiers arrived and the casern is so lively, they "
        .. "spend most of their time fawning around the soldiers, "
        .. "trying to earn some money by selling their mediocre goods.")
    say("It's really a shame, this village used to be such a lovely place "
        .. "to live, and with these soldiers around everyone behaves "
        .. "differently. Instead of doing honest and decent farm work, "
        .. "they think they can be merchants now!")
    patrol:unblock(ch)
end

local woman = create_npc_by_name("Eva", woman_talk)
woman:set_base_attribute(16, 1)
patrol:assign_being(woman)
schedule_every(10, function() patrol:logic() end)
