--[[

  Basilea - gossiping on the market place
  Home: House 1
  Relationships: Wife of Rowan

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

local patrol = NPCPatrol:new("Basilea")

local function woman_talk(npc, ch)
    patrol:block(ch)

    say("Did you already see Aquaria's shrine? You have to enter the "
        .. "mountains north west of there, then go east and south again.")
    say("I still think it'd be easier to just build a bridge across the "
        .. "river. But Priestess Linota is against that.")
    say("She says she needs some distance to the mundane village life, "
        .. "so she can concentrate on praising the gods.")
    say("Pretty lofty, if you ask me.")
    patrol:unblock(ch)
end

local woman = create_npc_by_name("Basilea", woman_talk)
woman:set_base_attribute(16, 1)
patrol:assign_being(woman)
schedule_every(11, function() patrol:logic() end)
