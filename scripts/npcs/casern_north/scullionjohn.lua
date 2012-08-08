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
    local function say(message)
        npc_message(npc, ch, message)
    end

    local rebelphilip_mole = chr_get_quest(ch, "rebelphilip_mole")

    if (rebelphilip_mole == "started") then
        say("Oh! It's you. What are you doing here! Are you nuts? "..
            "You have to leave before the guards see you. You weren't "..
            "followed I hope. Anyways, meet me at the Inn. We can talk "..
            "safely there.")
        chr_set_quest(ch, "rebelphilip_mole", "step1")
    elseif (rebelphilip_mole == "step1") then
        say("I already told you it wasn't safe to talk here. Go away!")
    else
        say("Psh, don't distract me! I need to wash the carrots and peel the potatoes. Then I have to cut the mushrooms.")
        say("Chef Odo will get angry if I'm not fast enough!")
    end
end

local scullion = create_npc_by_name("Scullion John", scullion_talk)

being_set_base_attribute(scullion, 16, 2)
local patrol = Patrol:new("Scullion John")
patrol:assign_being(scullion)
schedule_every(3, function() patrol:logic() end)
