--[[

  Francis

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

local function manTalk(npc, ch)
    local function say(message)
        npc_message(npc, ch, message)
    end

    say("Mh, I wonder if I should go to visit Isabella. She's an old woman living in the big house near the dock.")
    say("She lives alone there, and reminds me of my mom. So I visit her sometimes.")
end

local man = create_npc_by_name("Francis", manTalk)

being_set_base_attribute(man, 16, 1)
local patrol = Patrol:new("Francis")
patrol:assignBeing(man)
schedule_every(14, function() patrol:logic() end)
