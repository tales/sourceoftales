--[[

  Old Trader - doing not much in Mountain Watch near passage to Goldenfields

  Copyright (C) 2013 Przemysław Grzywacz

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

local patrol = NPCPatrol:new("Old Trader")

local function trader_talk(npc, ch)
    patrol:block(ch)

    say("You're not...");
    say("I'm waiting for someone. Go away!")

    patrol:unblock(ch)
end

local trader = create_npc_by_name("Old Trader", trader_talk)
trader:set_base_attribute(16, 1)
patrol:assign_being(trader)
schedule_every(10, function() patrol:logic() end)
