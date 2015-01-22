--[[

  Scullion John

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

local patrol = NPCPatrol:new("Scullion John")

local function scullion_talk(npc, ch)
    patrol:block(ch)
    local function guard_duty()
        say("Are you here to get the food for the poor bastards down in the prison?")
        local res = ask {
            "Yeah.",
            "No, I'm just hungry."
        }
        if (res == 2) then
            say("I'll just get into trouble for sneaking you some extra food! Forget about that!")
        else
            say("Finally, you're late. Here it is.")
            say("Oh, and you might want to give it to the prisoners directly. "
                .. "Sometimes the guard down there... likes some extra rations, if you know what I mean.")
            ch:inv_change("Bread", GUARDDUTY_BREADAMOUNT)
            chr_set_quest(ch, "soldier_goldenfields_guardduty", "gotfood")
            ch:set_questlog_description(QUESTID_GODWIN_GUARDDUTY,
                "Deliver the food to the prison in the casern's cellar.", true)
        end
    end

    local guardduty = chr_get_quest(ch, "soldier_goldenfields_guardduty")

    if guardduty == "started" then
        guard_duty()
    else
      say("Psh, don't distract me! I need to wash the carrots and peel the "
          .. "potatoes. Then I have to cut the mushrooms.")
      say("Chef Odo will get angry if I'm not fast enough!")
    end
    patrol:unblock(ch)
end

local scullion = create_npc_by_name("Scullion John", scullion_talk)

scullion:set_base_attribute(16, 2)
patrol:assign_being(scullion)
schedule_every(3, function() patrol:logic() end)
