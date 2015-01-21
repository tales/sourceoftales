--[[

  Guard Dain

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

local function guard_talk(npc, ch)
    local function deliver_food()
        say("Or do you have the food? Excellent! I was getting hun... "
            .."I mean, you can leave the rations here with me, I will take care of bringing it to the prisoners.")
        local res = ask {
            "I will give it to them myself.",
            "Sure, here it is."
        }
        if (res == 1) then
            say("Fine. Go ahead, just follow the stink, you can't miss it.")
        else
            local bread = ch:inv_count("Bread")
            if (bread >= GUARDDUTY_BREADAMOUNT) then
                ch:inv_change("Bread", -GUARDDUTY_BREADAMOUNT)
                chr_set_quest(ch, "soldier_goldenfields_guardduty", "deliveredfood")
                say("Great! Now you can go upst-")
                ch:set_questlog_description(QUESTID_GODWIN_GUARDDUTY,
                    "Talk to Prisoner Asher in the casern prison cell.", true)
                say("Did you hear that? I bet that was this farmer brat again. "
                    .. "Can you go and check him out in the cell?")
            else
                say("Hey, did you forget to bring it with you? Fool!")
            end
        end
    end

    local reputation = ch:reputation("Soldier reputation")

    if reputation >= REPUTATION_NEUTRAL then
        local guardduty = chr_get_quest(ch, "soldier_goldenfields_guardduty")

        say("Stinking cellar with stinking scum... "
            .."What are you doing down here? Here's nothing but stink.")

        if guardduty == "gotfood" then
            deliver_food()
        elseif guardduty == "deliveredfood" then
            say("Hey, weren't you going to check out the farmer brat in his cell?")
        end

    elseif reputation > REPUTATION_RELUCTANT then
        say("To get amnesty for your misconducts talk to Magistrate Eustace "
            .. "in Goldenfields.")
        ch:reputation("Soldier reputation", "Army", -1)
    else -- reputation <= REPUTATION_RELUCTANT
        say("Traitor!")
        ch:damage(80, 10, 9999, DAMAGE_PHYSICAL, ELEMENT_NEUTRAL)
    end
end

local guard = create_npc_by_name("Guard Dain", guard_talk)
