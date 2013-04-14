--[[

  Scullion John

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

local function scullion_talk(npc, ch)
    say("Psh, don't distract me! I need to wash the carrots and peel the "
        .. "potatoes. Then I have to cut the mushrooms.")
    say("Chef Odo will get angry if I'm not fast enough!")
end

local scullion = create_npc_by_name("Scullion John", scullion_talk)

being_set_base_attribute(scullion, 16, 2)
local patrol = Patrol:new("Scullion John")
patrol:assign_being(scullion)
schedule_every(3, function() patrol:logic() end)
