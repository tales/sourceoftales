--[[

  Recruit Hugh

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

local patrol = NPCPatrol:new("Recruit Hugh")

local function recruit_talk(npc, ch)
    patrol:block(ch)

    local reputation = ch:reputation("Soldier reputation")

    if reputation >= REPUTATION_NEUTRAL then
        local tutorial_equip = chr_get_quest(ch, "tutorial_equip")
        local tutorial_shop = chr_get_quest(ch, "tutorial_shop")

        say("I'm so exited! I'm going to be a great warrior, fighting in "
            .. "countless battles, until my enemies will "
            .. "shiver in fear as soon as they hear my name.")

        if (tutorial_equip == "done") and (tutorial_shop ~= "done") then
            say("But this armor they give you as recruit is ridiculous! But "
                .. "if you can keep a secret... you can keep a secret, right?")
            say("Blacwin can sell you some of the better armors from the "
                .. "supplies. Just ask him about that. "
                .. "Hey, but it wasn't me who told you about that, ok?")
            chr_set_quest(ch, "tutorial_shop", "done")
        end
        -- idea: could have a friend who later turns out to be one of the rebels
    elseif reputation > REPUTATION_RELUCTANT then
        say("Wow, you really got into trouble, heh? Why are you here? "
            .. "Shouldn't you talk to Magistrate Eustace?")
        ch:change_reputation("Soldier reputation", -1)
    else -- reputation <= REPUTATION_RELUCTANT
        say("Ah! Don't hurt me! Go away!")
        ch:damage({
            base = 50,
            delta = 10,
            chance_to_hit = 9999
        })
    end
    patrol:unblock(ch)
end

local recruit = create_npc_by_name("Recruit Hugh", recruit_talk)
recruit:set_base_attribute(16, 1)
patrol:assign_being(recruit)
schedule_every(10, function() patrol:logic() end)
