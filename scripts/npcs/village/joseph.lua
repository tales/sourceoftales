--[[

  Joseph, working on the fields

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

    say("Ouh, my back hurts. We're collecting stones from the field, before plowing.")
end

local man = create_npc_by_name("Joseph", manTalk)

being_set_base_attribute(man, 16, 1)

local patrol = Patrol:new("Joseph")
patrol:assignBeing(man)
schedule_every(10, function() patrol:logic() end)
