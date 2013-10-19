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

local function rebel_talk(npc, ch)
    patrol:block(ch)

    local function deliver_supplies()
        local supplies = chr_get_quest(ch, "rebel_goldenfields_supplies")
        if supplies == "started" then
            local choices = {
                "Innkeeper Norman asked me to bring you this supplies.",
                "What can I do to help?"
            }
            local res = ask(choices)
            if res == 1 then
                say("Great, we were waiting on those.")
                local pumpkin = ch:inv_count("Pumpkin")
                local foodshank = ch:inv_count("Food Shank")
                local apple = ch:inv_count("Apple")
                if (pumpkin >= REBEL_FOOD_PUMPKIN
                    and foodshank >= REBEL_FOOD_FOODSHANK
                    and apple >= REBEL_FOOD_APPLE)
                then
                    ch:inv_change("Pumpkin", -REBEL_FOOD_PUMPKIN,
                                    "Food Shank", -REBEL_FOOD_FOODSHANK,
                                    "Apple", -REBEL_FOOD_APPLE)

                    ch:change_reputation("Rebel reputation", 10)
                    ch:change_reputation("Soldier reputation", -5)
                    chr_set_quest(ch, "rebel_goldenfields_supplies", "done")
                    ch:inv_change("Robe Hood", 1)
                    ch:inv_change("Robe Shirt", 1)
                    say("Well done.")
                else
                    say("There's something missing. Don't think you can "
                        .. "outsmart us. Now you either go and get the "
                        .. "missing items, or you better not come back.")
                    say("Norman wanted to send us ".. REBEL_FOOD_PUMPKIN
                        .." pumpkins, ".. REBEL_FOOD_FOODSHANK
                        .. " food shanks and ".. REBEL_FOOD_APPLE
                        .. " apples.")
                    ch:change_reputation("Rebel reputation", -1)
                end
            end
        end
    end

    local reputation = ch:reputation("Rebel reputation")

    if reputation >= REPUTATION_NEUTRAL then
        say("Hello.")
        deliver_supplies()
        say("The army is sending out more and more patrols. You can help by "
            .. "fighting them back.")
        goldenfields_check_bounty(npc, ch,
                                  "rebel_goldenfields_killsoldiers", "Soldier")
    elseif reputation > REPUTATION_RELUCTANT then
        say("You worked against us. Talk to Innkeeper Norman to settle "
            .. "this conflict.")
        ch:change_reputation("Rebel reputation", -1)
    else -- reputation <= REPUTATION_RELUCTANT
        say("Traitor!")
        ch:damage(80, 10, 9999, DAMAGE_PHYSICAL, ELEMENT_NEUTRAL)
    end
    patrol:unblock(ch)
end

local rebel = create_npc_by_name("Rebel Henry", rebel_talk)
rebel:set_base_attribute(16, 1)
patrol:assign_being(rebel)
schedule_every(8, function() patrol:logic() end)
