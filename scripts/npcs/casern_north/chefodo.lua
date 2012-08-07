--[[

  Chef Odo

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

local function chef_talk(npc, ch)
    local function say(message)
        npc_message(npc, ch, message)
    end

    local function beetle_stew_start(amount)
        say("What are you doing in my kitchen? Don't stand in the way! "..
            "Unless you're here to help?")
        local choices = { "What do you need help with?",
                        "No, I'm just looking around."}
        local res = npc_choice(npc, ch, choices)
        if res == 1 then
            say("We need new supplies. I want to cook delicious beetle stew. "..
                "Those beetles doesn't live further north, but in this area "..
                "the wilderness is full of them!")
            local choices = { "Eew!",
                            "I never got the idea to eat beetles..."}
            local res = npc_choice(npc, ch, choices)
            say("I can't believe it! In other parts of the kingdom, this "..
                "is an expensive delicacy and here people "..
                "feel disgusted! No culture...")
            say("Listen, bring me ".. amount .. " of those beetles, and "..
                "I'm going to show you the most delicous meal you "..
                "ever tasted.")
            chr_set_quest(ch, "soldier_beetlestew", "gotorder")
        else
            say("Pah. Then don't waste my time.")
        end
    end

    local function beetle_stew_check(amount)
        local beetle_amount = chr_inv_count(ch, true, false, "Beetle Corpus")
        say("Please bring me ".. amount .. " beetles, so I can create the "..
            "most delicious beetle stew.")
        if beetle_amount >= amount then
            local choices = { "Here they are.",
                            "I didn't get them yet."}
            local res = npc_choice(npc, ch, choices)
            if res == 1 then
                beetle_amount = chr_inv_count(ch, true, false, "Beetle Corpus")
                if beetle_amount >= amount then
                    chr_inv_change(ch, "Beetle Corpus", -amount)
                    chr_money_change(ch, 100)
                    say("Wonderful, wonderful! I'll start with the beetle "..
                        "stew right now.")
                    chr_set_quest(ch, "soldier_beetlestew", "done")
                else
                    say("Eh? Don't talk nonsense.")
                end
            end
        end
    end

    local BEETLE_AMOUNT = 10
    local beetle_quest = chr_get_quest(ch, "soldier_beetlestew")

    if beetle_quest == "done" then
        say("Ah, my friend. Thanks again for bringing me those beetles. "..
            "Here, have a bowl of beetle stew!")
        being_heal(ch, 150)
    elseif beetle_quest == "gotorder" then
        beetle_stew_check(BEETLE_AMOUNT)
    else
        beetle_stew_start(BEETLE_AMOUNT)
    end
end

local chef = create_npc_by_name("Chef Odo", chef_talk)

being_set_base_attribute(chef, 16, 1)
local patrol = Patrol:new("Chef Odo")
patrol:assignBeing(chef)
schedule_every(11, function() patrol:logic() end)

