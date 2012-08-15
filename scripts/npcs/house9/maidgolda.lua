--[[

  Maid Golda

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

local function maid_talk(npc, ch)
    local function say(message)
        npc_message(npc, ch, message)
    end

    say("Oh, hello. What are you doing here? Do you want to talk to "
        .. "Magistrate Eustace? He should be in the entrance room.")
    say("I need to work, otherwise Lady Primeveire will get angry with me.")
end

local maid = create_npc_by_name("Maid Golda", maid_talk)

being_set_base_attribute(maid, 16, 1)
local patrol = Patrol:new("Maid Golda")
patrol:assign_being(maid)
schedule_every(11, function() patrol:logic() end)
