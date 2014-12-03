--[[

  Veteran Godwin

  Copyright (C) 2012 Jessica Tölke
  Copyright (C) 2013 Przemysław Grzywacz
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

require "scripts/functions/bounty"

local patrol = NPCPatrol:new("Veteran Godwin")

local function veteran_talk(npc, ch)
    patrol:block(ch)

    local function send_tutorial(tutorial_godwin_talk, tutorial_fight, tutorial_equip)
        say("Hey, rookie. You aren't paid for standing in the landscape "
            .. "and looking like a sheep.")
        say("You should better hurry to get to the basic training unless you "
            .. "want to do extra hours in the kitchen during the next month.")

        local choices = {
            "In the kitchen? I'm a strong fighter!",
            "Alright, thank you, where do I have to go?",
            "I was promised fame and gold for joining the army!"
        }
        local res = ask(choices)

        if res == 1 then
            say("Don't make me laugh! I'd be surprised if you'd know at what "
                .. "end to hold a sword.")
        elseif res == 2 then
            say("Watch out, this isn't a friendly place for a wimp.")
        elseif res == 3 then
            say("Hah, recruiters are liers. It's their job to tell fairytales "
                .. "about fame to dumbheads like you.")
            say("The only thing that's awaiting you is a lot of hard work, "
                .. "boy.")
        end

        -- check if tutorial quests were already assigned

        if tutorial_godwin_talk ~= "done" then
            -- end the quest
            chr_set_quest(ch, "tutorial_godwin_talk", "done")
            ch:set_questlog_state(QUESTID_TUTORIAL_GODWIN_TALK, QUEST_FINISHED, true)
            ch:change_reputation("Rebel reputation", REPUTATION_RELUCTANT - 1)
        end


        if tutorial_fight == "" then
            say("Now go, talk to Instructor Alard, so he can show you how you can "
                .. "avoid being speared by the first enemy you'll encounter.")
            ch:set_questlog(QUESTID_TUTORIAL_FIGHT, QUEST_OPEN, "Learn to fight",
                "Instructor Alard will teach you how to fight.\nTalk to him.", true)
        elseif tutorial_fight ~= "done" then
            say("I see you didn't finish Instructor Alard's task. You should look into it now.")
        end

        if tutorial_equip == "" then
            say("Oh, and get your equipment from Blacwin. "
                .. "You should at least look like a soldier.")
            ch:set_questlog(QUESTID_TUTORIAL_EQUIP, QUEST_OPEN, "Look like a soldier!",
                "Go to Blacwin and get an armor.", true)
            chr_set_quest(ch, "tutorial_armor", "todo")
        elseif tutorial_equip ~= "done" then
            say("Don't forget about your armor. Talk to Blacwin.")
        end

        say ("Come back to me when you're done.")

    end

    local function directions_to_pub()
        say("When you leave the casern, go south east over the "
            .. "Goldenfields market. Don't let those brash merchants "
            .. "distract you. Further into the village there are also "
            .. "some food stands.")
        say("Just north of there you can find what they call a pub in this place.")
    end

    local function help_farmers()
        local helpfarmers = chr_get_quest(ch, "soldier_goldenfields_helpfarmers")
        if (helpfarmers == "") then
            say("I see you finished the basic training and got your equipment. "
                .. "I've got the perfect mission to fit your abilities.")
            say("Arbert, a local farmer, has requested help to deal with beetles destroying the crops. "
              .. "Go meet him to get specific instructions. "
              .. "He's either on the fields overseeing the workers or hanging out in the pub.")
            local choices = {
                "I'm on my way.",
                "You want me to hunts bugs?! I'm a soldier!"
            }
            local res = ask(choices)
            if res == 1 then
                say("So what are you still doing here? Get going!")
            elseif res == 2 then
                say("Yeah, I know, I know. It's ridiculous. Soldiers hunting bugs for dirty farm people... But those are the orders.")
                say("If you need to know, they don't want the local people getting any more unhappy. Have you heard about the rebels? "
                  .. "Unhappy villagers means more support for that nuisance.")
                say("And now stop questioning orders and go do your job!")
            end
            ch:set_questlog(QUESTID_GODWIN_HELPFARMERS, QUEST_OPEN, "Bugs on the Fields",
                "Meet Arbert in Goldenfields and get more information about the problem with the beetles.", true)
            chr_set_quest(ch, "soldier_goldenfields_helpfarmers", "meet")
        elseif (helpfarmers == "helped") then
            say("Did you take care of the farmer's problem? That's great! "
                .. "Hopefully that will stop the moaning for a while.")
            say("You've earned yourself your first pay.")
            say("Don't spend all of it on the pub and come back when you are ready for your next orders.")
            chr_set_quest(ch, "soldier_goldenfields_helpfarmers", "done")
            ch:set_questlog_state(QUESTID_GODWIN_HELPFARMERS, QUEST_FINISHED, true)
            ch:change_money(20)
        else
            say("Are you still here? Go talk to Arbert to find out what's the problem with the beetles.")
            local choices = {
                "Yes, sir.",
                "I can't find him."
            }
            local res = ask(choices)
            if res == 2 then
                say("If he isn't on the fields overseeing the workers, he's probably in the pub. "
                .. "I bet he's there, lazy as he is. The pub is in the middle of the village, right behind the pond.")
                directions_to_pub()
            end
        end
    end

    local function scout_forest()
        local scoutforest = chr_get_quest(ch, "soldier_goldenfields_scoutforest")
        if (scoutforest == "") then
            say("I have a new task for you. Should be simple.")
            say("Yesterday a messenger arrived, telling us the next weapon and armor supply delivery "
                .. "has reached the mountain path and is going to arrive soon.")
            say("But they're not here yet though I've expected them before noon. "
                .. "I wonder if they encountered some problem, maybe a breaking of an axle. "
                .. "They always use the carts until they break...")
            say("I want you to go scouting and see if you can find them. "
                .. "The path through the mountains leads to the forest in the west.")
            say("So take the path into the forest on the west and then go north. "
                .. "Report back to me with your findings.")
            local choices = {
                "Yes, sir."
            }
            ask(choices)
            say("Oh, and one more thing before you go.")
            say("There are rumors that the rebels set up camp in the forest. "
                .. "I don't think they are any kind of a threat, but you're still rather unexperienced.")
            say("So remember, this is a scouting mission. "
                .. "If you get into any trouble bigger than you can handle, retreat.")
            ch:set_questlog(QUESTID_GODWIN_SCOUTING, QUEST_OPEN, "Missing delivery",
                "Scout the forest for a sign of the missing weapon and armor delivery.", true)
            chr_set_quest(ch, "soldier_goldenfields_scoutforest", "started")
        elseif (scoutforest == "started") then
            say("Any news from the missing supply delivery yet?")
            local choices = {
                "Not yet, I'm on my way.",
                "Where do you want me to look again?"
            }
            local res = ask(choices)
            if (res == 2) then
                say("Aquaria grant me patience, weren't you listening before? "
                    .. "They are supposed to come through the forest west of here, "
                    .. "from the northern mountain path.")
                end
        elseif (scoutforest == "information") then
            say("Kid, there you are. Did you find out about the supply delivery? "
                .. "Did their cart break?")
            local choices = {
                "Groups of rebels are patroling the forest.",
                "They got into an ambush."
            }
            local res = ask(choices)
            if res == 1 then
                say("Patroling? They've reached that level of organization already? "
                    .. "But what about the delivery?")
                ask("They got into an ambush.")
                say("An ambush? By the rebels? And they weren't able to fend them off?")
            else
                say("An ambush? How could that be? We're far behind the combat zone... ")
                ask("Groups of rebels are patroling the forest.")
                say("You mean to say the rebels are organized and strong enough to ambush "
                    .. "an army supply delivery and succeed?!")
            end
            say("...")
            say("Recruit " .. ch:name() .. ", I underestimated the threat those rebels pose and "
                .. "sent you on a mission far more dangerous than I intended. "
                .. "I'm responsible for you new kids.")
            say("You nevertheless did your job very well. Here is a little bonus for you.")
            chr_set_quest(ch, "soldier_goldenfields_scoutforest", "done")
            ch:set_questlog_state(QUESTID_GODWIN_SCOUTING, QUEST_FINISHED, true)
            ch:change_money(40)
            say("Report back to me once you got some rest.")
        end
    end

    local function guard_duty()
        local guardduty = chr_get_quest(ch, "soldier_goldenfields_guardduty")
        if (guardduty == "") then
            say("All right, rookie. It's your turn with guard duty in the prison. "
                .. "Fetch their food in the kitchen and bring it to them.")
            ch:set_questlog(QUESTID_GODWIN_GUARDDUTY, QUEST_OPEN, "The other side of the medal...",
                "Fetch food for the prisoners from the kitchen in the casern.", true)
            chr_set_quest(ch, "soldier_goldenfields_guardduty", "started")
        elseif (guardduty == "reportback") then
            say("Back from the grunt work? I know guard duty is boring, kid, but it's part of the job.")
            chr_set_quest(ch, "soldier_goldenfields_guardduty", "done")
            ch:set_questlog_state(QUESTID_GODWIN_GUARDDUTY, QUEST_FINISHED, true)
            ch:change_money(20)
            say("Report back to me when you're ready for your next task.")
        else
            say("You're supposed to be on guard duty in the prison. What are you doing here?")
        end
    end

    local function collect_taxes()
        local taxes = chr_get_quest(ch, "soldier_goldenfields_taxes")
        if (taxes == "") then
            say("Are you ready for your next task? Very well. I've got "
                .. "something for you. The Innkeeper from Goldenfields, "
                .. "Norman, is late with paying his taxes.")
            say("There was quite "
                .. "some moaning among the villagers because of the extra "
                .. "taxes due to the war. Hah! We're the ones keeping "
                .. "them safe, ungrateful wretches.")
            say("I want you to get the outstanding " .. GOLDENFIELDS_TAXES
                .. " GP from that innkeeper.")
            chr_set_quest(ch, "soldier_goldenfields_taxes", "gotorder")
            say("You can find the Inn in Goldenfields south east of the "
                .. "casern.")
            ch:set_questlog(QUESTID_GODWIN_CLAIM_TAXES, QUEST_OPEN,
                            "Gather taxes", "Talk to the inn keeper and " ..
                            "gather the outstanding taxes from him.\n" ..
                            "You can find the inn in the center of the "..
                            "village, near to a small pond.", true)
        else
            say("Did you get the money from that innkeeper?")
            local choices = {
                "I'm on my way.",
                "Here it is.",
                "I can't find it, where do I have to go?"
            }
            local res = ask(choices)
            if res == 2 then
                local money = ch:money()
                if money >= GOLDENFIELDS_TAXES then
                    ch:change_money(-GOLDENFIELDS_TAXES)
                    chr_set_quest(ch, "soldier_goldenfields_taxes", "done")
                    ch:change_reputation("Soldier reputation", 10)
                    ch:change_money(40)
                    say("Well done, kid.")
                    ch:set_questlog_state(QUESTID_GODWIN_RETURN_TAXES, QUEST_FINISHED, true)
                else
                    say("Where is the money? Did you spend it on booze? Kid, "
                        .. "this isn't a place to fool around. "
                        .. "Get me the ".. GOLDENFIELDS_TAXES .. " GP.")
                end
            elseif res == 3 then
                say("You're not very clever, are you? All right, listen.")
                directions_to_pub()
            end
        end
    end


    local reputation = ch:reputation("Soldier reputation")

    if reputation >= REPUTATION_NEUTRAL then
        local tutorial_fight = chr_get_quest(ch, "tutorial_fight")
        local tutorial_equip = chr_get_quest(ch, "tutorial_equip")
        local tutorial_godwin_talk = chr_get_quest(ch, "tutorial_godwin_talk")
        local helpfarmers = chr_get_quest(ch, "soldier_goldenfields_helpfarmers")
        local scoutforest = chr_get_quest(ch, "soldier_goldenfields_scoutforest")
        local guardduty = chr_get_quest(ch, "soldier_goldenfields_guardduty")
        local taxes = chr_get_quest(ch, "soldier_goldenfields_taxes")

        if (tutorial_fight ~= "done") or (tutorial_equip ~= "done") or (tutorial_godwin_talk ~= "done") then
            -- show tutorial talk if any of the blow is true
            -- * first talk to Godwin
            -- * quest tutorial fight is not completed
            -- * quest tutorial armor is not completed
            send_tutorial(tutorial_godwin_talk, tutorial_fight, tutorial_equip)
        elseif (helpfarmers ~= "done") then
            help_farmers()
        elseif (scoutforest ~= "done") then
            scout_forest()
        elseif (guardduty ~= "done") then
            guard_duty()
        elseif (taxes ~= "done") then
            collect_taxes()
        else
            say("I don't have anything specific for you to do right now. "
                .. "But you can help by chasing some of the rebels in the "
                .. "forest. And better not go alone, you still look a bit "
                .. "look a bit too weakly to deal with them on your own.")
            say("We give out rewards for many defeated rebels. Lieutenant "
                .. "Bennet on the second floor of the casern gives them out.")
        end
    elseif reputation > REPUTATION_RELUCTANT then
        say("Why are you here? "
            .. "Talk to Magistrate Eustace to get amnesty from your crimes!")
        ch:change_reputation("Soldier reputation", -1)
    else -- reputation <= REPUTATION_RELUCTANT
        say("I can't deny you're brave, but that won't help you now!")
        ch:damage(90, 30, 9999, DAMAGE_PHYSICAL, ELEMENT_NEUTRAL)
    end
    patrol:unblock(ch)
end


local function found_ambush_trace(ch)
    if ch:type() ~= TYPE_CHARACTER then
        return
    end

    local quest = chr_try_get_quest(ch, "soldier_goldenfields_scoutforest")
    if (quest == "started") then
        ch:message("An ambush happened here! Only some broken armor and the cart is left.")
        ch:set_questlog_description(QUESTID_GODWIN_SCOUTING,
                "Report back to Godwin.", true)
        chr_set_quest(ch, "soldier_goldenfields_scoutforest", "information")
    end
end

local veteran = create_npc_by_name("Veteran Godwin", veteran_talk)

veteran:set_base_attribute(16, 1)
patrol:assign_being(veteran)
schedule_every(10, function() patrol:logic() end)

create_trigger_by_name("Ambush trace", found_ambush_trace)

