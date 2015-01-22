--[[

  Lieutenant Giles

  Copyright (C) 2012 Jessica Tölke
  Copyright (C) 2014 Jessica Beller

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

local patrol = NPCPatrol:new("Lieutenant Giles")

local function lieutnant_talk(npc, ch)
    patrol:block(ch)
    say("We're trying to discuss something important here. Go back downstairs.")
    patrol:unblock(ch)
end

local lieutnant = create_npc_by_name("Lieutenant Giles", lieutnant_talk)

lieutnant:set_base_attribute(16, 3)
patrol:assign_being(lieutnant)
schedule_every(9, function() patrol:logic() end)
