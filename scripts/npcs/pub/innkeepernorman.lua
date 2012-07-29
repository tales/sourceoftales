--[[

  Innkeeper Norman

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

local function innkeeperTalk(npc, ch)
    local function say(message)
        npc_message(npc, ch, message)
    end

    local function collect_taxes()
        local persuaded = false
        say("Hello. How can I help you?")
        local choices = { "I'm here to get the outstanding taxes!"}
        local res = npc_choice(npc, ch, choices)
        say("Oh, I see. I wonder, do you think those taxes are fair?")
        local choices = { "That doesn't matter!",
                        "I.. uh.. what do you mean?"}
        local res = npc_choice(npc, ch, choices)
        if res == 1 then
            say("I see you're completely brainwashed. Don't you want to think for yourself?")
            local choices = { "Are you trying to distract? The taxes!",
                            "Yeah, I want to. What's your point?"}
            local res = npc_choice(npc, ch, choices)
            if res == 2 then
                say("My point? Well, you don't have to be a brainless obeying soldier. I can show you something else. "..
                    "Are you interested?")
                local choices = { "Yes, tell me more.",
                                "I signed a contract when joining the army! Stop that blabber and give me the taxes."}
                local res = npc_choice(npc, ch, choices)
                if res == 1 then
                    persuaded = true
                end
            end
        else
            say("The army squeezes the last money out of the upright citizens, to pay for a war that happens far away, "..
                "for a king we don't know and who probably never heard that Goldenfields even exists.")
            say("Do you think this is right? Do you really want to support this?")
            local choices = { "You're right! I don't want to be part of this. What can I do?",
                            "I.. I never looked at it this way.."}
            local res = npc_choice(npc, ch, choices)
            if res == 1 then
                persuaded = true
            else
                say("You don't have to stay part of this injustice.")
                local choices = { "And I don't want to!",
                                "But I signed a contract! No, I'll stay loyal. The taxes, now."}
                local res = npc_choice(npc, ch, choices)
                if res == 1 then
                    persuaded = true
                end
            end
        end

        if persuaded then
            say("That's what I wanted to hear, friend! You should talk to Henry. "..
                "He's hiding in the forest, together with some people who share our ideals.")
            say("I have some supplies they need, please take it with you when you go there.")
            chr_inv_change(ch, "Pumpkin", REBEL_FOOD_PUMPKIN,
                            "Food Shank", REBEL_FOOD_FOODSHANK,
                            "Apple", REBEL_FOOD_APPLE)
            chr_set_quest(ch, "soldier_goldenfieldstaxes", "done")
            local reputation = read_reputation(ch, "rebel_reputation")
            reputation = reputation + 10
            chr_set_quest(ch, "rebel_reputation", tostring(reputation))
            local soldier_reputation = read_reputation(ch, "soldier_reputation")
            soldier_reputation = soldier_reputation - 10
            chr_set_quest(ch, "soldier_reputation", tostring(reputation))
            chr_set_quest(ch, "rebel_supplies", "started")
        else
            say("As you wish. How much do I have to pay?")
            local money = npc_ask_integer(npc, ch, GOLDENFIELDS_TAXES - 40, GOLDENFIELDS_TAXES + 40, GOLDENFIELDS_TAXES)
            chr_money_change(ch, money)
            chr_set_quest(ch, "soldier_goldenfieldstaxes", "gotmoney")
            local reputation = read_reputation(ch, "rebel_reputation")
            reputation = reputation - 10 + (GOLDENFIELDS_TAXES - money)/10
            chr_set_quest(ch, "rebel_reputation", tostring(reputation))
        end
    end

    local function reputationDependent()
        local reputation = read_reputation(ch, "rebel_reputation")
        if reputation >= REPUTATION_NEUTRAL then
            say("Hello. Make yourself at home.")
            -- LATER: some more talk, maybe depending on the quest state
        else
            say("Are you here to make up for the damage you caused? We accept you back if you pay recompensation.")
            local choices = { "Ok, what do I have to pay?",
                            "No!"}
            local res = npc_choice(npc, ch, choices)
            if res == 1 then
                apply_amnesty(npc, ch, "rebel_reputation", "soldier_reputation")
            else
                say("Hm. As you wish.")
            end
        end
    end

    local taxes = chr_get_quest(ch, "soldier_goldenfieldstaxes")

    if (taxes == "gotorder") then
        collect_taxes()
    else
        reputationDependent()
    end
end

local innkeeper = create_npc_by_name("Innkeeper Norman", innkeeperTalk)
