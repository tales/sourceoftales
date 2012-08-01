--[[

  Rebel Henry

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

require "scripts/functions/bounty"

local patrol = NPCPatrol:new("Rebel Henry")

local function rebelTalk(npc, ch)
    patrol:block(ch)
    local function say(message)
        npc_message(npc, ch, message)
    end

    local reputation = read_reputation(ch, "rebel_reputation")

    if reputation >= REPUTATION_NEUTRAL then
        say("Hello.")
        local supplies = chr_get_quest(ch, "rebel_supplies")
        if supplies == "started" then
            local choices = { "Innkeeper Norman asked me to bring you this supplies.",
                            "What can I do to help?"}
            local res = npc_choice(npc, ch, choices)
            if res == 1 then
                say("Great, we were waiting on those.")
                local pumpkin = chr_inv_count(ch, true, false, "Pumpkin")
                local foodshank = chr_inv_count(ch, true, false, "Food Shank")
                local apple = chr_inv_count(ch, true, false, "Apple")
                if (pumpkin >= REBEL_FOOD_PUMPKIN) and (foodshank >= REBEL_FOOD_FOODSHANK) and (apple >= REBEL_FOOD_APPLE) then
                    chr_inv_change(ch, "Pumpkin", -REBEL_FOOD_PUMPKIN,
                                    "Food Shank", -REBEL_FOOD_FOODSHANK,
                                    "Apple", -REBEL_FOOD_APPLE)
                    reputation = reputation + 10
                    chr_set_quest(ch, "rebel_reputation", tostring(reputation))
                    local soldier_reputation = read_reputation(ch, "soldier_reputation")
                    soldier_reputation = soldier_reputation - 5
                    chr_set_quest(ch, "soldier_reputation", tostring(soldier_reputation))
                    chr_set_quest(ch, "rebel_supplies", "done")
                    chr_inv_change(ch, "Robe Hood", 1)
                    chr_inv_change(ch, "Robe Shirt", 1)
                    say("Well done.")
                else
                    say("There's something missing. Don't think you can outsmart us. Now you either go and get the "..
                        "missing items, or you better not come back.")
                    say("Norman wanted to send us ".. REBEL_FOOD_PUMPKIN .." pumpkins, ".. REBEL_FOOD_FOODSHANK ..
                        " food shanks and ".. REBEL_FOOD_APPLE .. " apples.")
                    reputation = reputation - 1
                    chr_set_quest(ch, "rebel_reputation", tostring(reputation))
                end
            end
        end
        say("The army is sending out more and more patrols. You can help by fighting them back.")
        goldenfields_check_bounty(ch, "rebel_goldenfields_killsoldiers", "Soldier")
    elseif reputation > REPUTATION_RELUCTANT then
        say("You worked against us. Talk to Innkeeper Norman to settle this conflict.")
    else -- reputation <= REPUTATION_RELUCTANT
        say("Traitor!")
        being_damage(ch, 80, 10, 9999, DAMAGE_PHYSICAL, ELEMENT_NEUTRAL)
    end
    patrol:unblock(ch)
end

local rebel = create_npc_by_name("Rebel Henry", rebelTalk)
being_set_base_attribute(rebel, 16, 1)
patrol:assignBeing(rebel)
schedule_every(8, function() patrol:logic() end)
