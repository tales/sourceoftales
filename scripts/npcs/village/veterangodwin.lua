--[[

  Veteran Godwin

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

local patrol = NPCPatrol:new("Veteran Godwin")

local function veteranTalk(npc, ch)
    patrol:block(ch)
    local function say(message)
        npc_message(npc, ch, message)
    end
    local function send_tutorial()
        say("Hey, rookie. You aren't paid for standing in the landscape and looking like a sheep.")
        say("You should better hurry to get to the basic training unless you want to do extra hours in the kitchen "..
            "during the next month.")

        local choices = { "In the kitchen? I'm a strong fighter!",
                        "Alright, thank you, where do I have to go?",
                        "I was promised fame and gold for joining the army!" }

        local res = npc_choice(npc, ch, choices)

        if res == 1 then
            say("Don't make me laugh! I'd be surprised if you'd know at what end to hold a sword.")
        elseif res == 2 then
            say("Watch out, this isn't a friendly place for a wimp.")
        elseif res ==3 then
            say("Hah, recruiters are liers. It's their job to tell fairytales about fame to dumbheads like you.")
            say("The only thing that's awaiting you is a lot of hard work, boy.")
        end

        say("Now go, talk to Instructor Alard, so he can show you how you can avoid being speared by the first "..
            "enemy you'll encounter.")
        say("Oh, and get your equipment from Blacwin. You should at least look like a soldier.")
        say ("Come back to me when you're done.")
    end

    local function collect_taxes()
        local taxes = chr_get_quest(ch, "soldier_goldenfieldstaxes")
        if (taxes == "") then
            say("You're done with your basic training? Very well. I've got some task for you. "..
                "The Innkeeper from Goldenfields, Norman, is late with paying his taxes. "..
                "There was quite some moaning among the villagers because of the extra taxes due to the war. "..
                "Hah! We're the ones keeping them safe, ungrateful wretches.")
            say("I want you to get the outstanding ".. GOLDENFIELDS_TAXES .. " GP from that innkeeper.")
            chr_set_quest(ch, "soldier_goldenfieldstaxes", "gotorder")
        elseif (taxes == "gotorder") then
            say("What are you waiting for? Go and get the outstanding taxes from Innkeeper Norman.")
        elseif (taxes == "gotmoney") then
            say("Did you get the money from that innkeeper? Let me see.")
            local money = chr_money(ch)
            if money >= GOLDENFIELDS_TAXES then
                chr_money_change(ch, -GOLDENFIELDS_TAXES)
                chr_set_quest(ch, "soldier_goldenfieldstaxes", "done")
                change_reputation(ch, "soldier_reputation", "Army", 10)
                chr_money_change(ch, 40)
                say("Well done, kid.")
            else
                say("Where is the money? Did you spend it on booze? Kid, this isn't a place to fool around. "..
                    "Get me the ".. GOLDENFIELDS_TAXES .. " GP.")
            end
        end
    end


    local reputation = read_reputation(ch, "soldier_reputation")

    if reputation >= REPUTATION_NEUTRAL then
        local tutorial_fight = chr_get_quest(ch, "tutorial_fight")
        local tutorial_equip = chr_get_quest(ch, "tutorial_equip")
        local taxes = chr_get_quest(ch, "soldier_goldenfieldstaxes")

        if (tutorial_fight ~= "done") or (tutorial_equip ~= "done") then
            send_tutorial()
        elseif (taxes ~= "done") then
            collect_taxes()
        else
        say("I don't have anything specific for you to do right now. "..
            "But you can help by chasing some of the rebels in the forest. And better not go alone, you still "..
            "look a bit too weakly to deal with them on your own.")
        say("We give out rewards for many defeated rebels.")
            goldenfields_check_bounty(npc, ch, "soldier_goldenfields_killrebels", "Rebel")
        end
    elseif reputation > REPUTATION_RELUCTANT then
        say("Why are you here? Talk to Magistrate Eustace to get amnesty from your crimes!")
        change_reputation(ch, "soldier_reputation", "Army", -1)
    else -- reputation <= REPUTATION_RELUCTANT
        say("I can't deny you're brave, but that won't help you now!")
        being_damage(ch, 90, 30, 9999, DAMAGE_PHYSICAL, ELEMENT_NEUTRAL)
    end
    patrol:unblock(ch)
end
-- TODO: add start equipment in global_events.lua, on_chr_birth

local veteran = create_npc_by_name("Veteran Godwin", veteranTalk)

being_set_base_attribute(veteran, 16, 1)
patrol:assignBeing(veteran)
schedule_every(10, function() patrol:logic() end)
