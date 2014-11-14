--[[

  Mary - gossiping on the market place
  Home: House 8
  Relationships: Wife of Merchant Gilbert and mother of Oliver

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

local patrol = NPCPatrol:new("Mary")

local function woman_talk(npc, ch)
    patrol:block(ch)

    say("Magistrate Eustace lives in that house over there. Together with "
        .. "his wife. She's called Lady Primeveire.")
    say("Alone that name shows that those people don't belong here. Snobbish "
        .. "townspeople, I tell you. They even have a maid with them, "..
        "the lady seems to be too dignified to do homework...")
    say("They came together with all these soldiers, and are supposed to "
        .. "help with 'adjustment of differences' and as "..
        "'official representants of our beloved King Richard'.")
    say("As if we need that! We were doing fine with our businesses without "
        .. "any arrogant townspeople around.")
    patrol:unblock(ch)
end

local woman = create_npc_by_name("Mary", woman_talk)
woman:set_base_attribute(16, 1)
patrol:assign_being(woman)
schedule_every(9, function() patrol:logic() end)
