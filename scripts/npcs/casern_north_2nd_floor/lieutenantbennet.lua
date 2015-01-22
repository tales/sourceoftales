--[[

  Lieutenant Bennet

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

local patrol = NPCPatrol:new("Lieutenant Bennet")

local function lieutnant_talk(npc, ch)
    patrol:block(ch)
    local reputation = ch:reputation("Soldier reputation")

    if reputation >= REPUTATION_NEUTRAL then
        local tutorial_fight = chr_get_quest(ch, "tutorial_fight")
        local tutorial_equip = chr_get_quest(ch, "tutorial_equip")

        if (tutorial_fight ~= "done") or (tutorial_equip ~= "done") then
            say("Oh? What are you doing here? This area is only for the "
                .. "higher ranks.")
        else
            say("Are you here to receive the reward for the rebel bounty?")
            goldenfields_check_bounty(npc, ch,
                                      "soldier_goldenfields_killrebels",
                                      "Rebel")
        end
    elseif reputation > REPUTATION_RELUCTANT then
        say("You dare to come here after what you've done? "
            .. "Talk to Magistrate Eustace to get amnesty from your crimes!")
        ch:change_reputation("Soldier reputation", -1)
    else -- reputation <= REPUTATION_RELUCTANT
        say("I can't deny you're brave, but that won't help you now!")
        ch:damage(90, 30, 9999, DAMAGE_PHYSICAL, ELEMENT_NEUTRAL)
    end
    patrol:unblock(ch)
end

local lieutnant = create_npc_by_name("Lieutenant Bennet", lieutnant_talk)

lieutnant:set_base_attribute(16, 1)
patrol:assign_being(lieutnant)
schedule_every(13, function() patrol:logic() end)
