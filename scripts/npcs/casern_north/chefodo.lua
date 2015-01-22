--[[

  Chef Odo

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

local patrol = NPCPatrol:new("Chef Odo")

local function chef_talk(npc, ch)
    patrol:block(ch)
    local function guard_duty()
        say("Why are you in my kitchen? I'm working here!")
        local choices = {
                "I have orders to bring food to the prisoners.",
                "Just saying hi."
        }
        local res = ask(choices)
        if res == 1 then
            say("Don't bother me with trivia like that! Ask John.")
        end
    end

    local function beetle_stew_start(amount)
        say("Don't loiter in my kitchen! Don't stand in the way! "
            .. "Unless you're here to help?")
        local choices = {
            "What do you need help with?",
            "No, I'm just looking around."
        }
        local res = ask(choices)
        if res == 1 then
            say("We need new supplies. I want to cook delicious beetle stew. "
                .. "Those beetles don't live further north, but in this area "
                .. "the wilderness is full of them!")
            local choices = {
                "Eew!",
                "I never got the idea to eat beetles..."
            }
            local res = ask(choices)
            say("I can't believe it! In other parts of the kingdom, this "
                .. "is an expensive delicacy and here people "
                .. "feel disgusted! No culture...")
            say("Listen, bring me ".. amount .. " of those beetles, and "
                .. "I'm going to show you the most delicious meal you "
                .. "ever tasted.")
            chr_set_quest(ch, "soldier_goldenfields_beetlestew", "gotorder")
            ch:set_questlog(QUESTID_GOLDENFIELDS_BEETLE_STEW, QUEST_OPEN,
                "Beetle stew", "Bring " .. amount ..
                " beetles to Chef Odo. He'll make a delicious beetle stew.", true)
        else
            say("Pah. Then don't waste my time.")
        end
    end

    local function beetle_stew_check(amount)
        local beetle_amount = ch:inv_count("Beetle Corpus")
        say("Please bring me " .. amount .. " beetles, so I can create the "
            .. "most delicious beetle stew.")
        if beetle_amount >= amount then
            local choices = {
                "Here they are.",
                "I didn't get them yet."
            }
            local res = ask(choices)
            if res == 1 then
                beetle_amount = ch:inv_count("Beetle Corpus")
                if beetle_amount >= amount then
                    ch:inv_change("Beetle Corpus", -amount)
                    ch:change_money(100)
                    ch:set_questlog_state(QUESTID_GOLDENFIELDS_BEETLE_STEW,
                        QUEST_FINISHED, true)
                    say("Wonderful, wonderful! I'll start with the beetle "
                        .. "stew right now. Here's something for your trouble!")
                    chr_set_quest(ch, "soldier_goldenfields_beetlestew", "done")
                else
                    say("Eh? Don't talk nonsense.")
                end
            end
        end
    end

    local BEETLE_AMOUNT = 10
    local beetle_quest = chr_get_quest(ch, "soldier_goldenfields_beetlestew")
    local guardduty = chr_get_quest(ch, "soldier_goldenfields_guardduty")

    if guardduty == "started" then
        guard_duty()
    end

    if beetle_quest == "done" then
        say("Ah, my friend. Thanks again for bringing me those beetles. "
            .. "Here, have a bowl of beetle stew!")
        ch:heal(150)
    elseif beetle_quest == "gotorder" then
        beetle_stew_check(BEETLE_AMOUNT)
    else
        beetle_stew_start(BEETLE_AMOUNT)
    end
    patrol:unblock(ch)
end

local chef = create_npc_by_name("Chef Odo", chef_talk)

chef:set_base_attribute(16, 1)
patrol:assign_being(chef)
schedule_every(11, function() patrol:logic() end)

