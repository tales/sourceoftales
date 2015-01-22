--[[

  Recruit Alan

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

local patrol = NPCPatrol:new("Recruit Jordan")

local function recruit_talk(npc, ch)
    patrol:block(ch)
    say("This is nice. Everything is calm and peaceful. "
        .. "I mean, we're getting paid for sitting around here, "
        .. "drinking and eating. Isn't that wonderful?")
    patrol:unblock(ch)
end

local recruit = create_npc_by_name("Recruit Jordan", recruit_talk)

recruit:set_base_attribute(16, 1)
patrol:assign_being(recruit)
schedule_every(27, function() patrol:logic() end)
