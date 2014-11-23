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

local patrol = NPCPatrol:new("Innkeeper Norman")

local function innkeeper_talk(npc, ch)
    patrol:block(ch)

    local function set_respawn()
        local x, y = get_named_coordinate("Goldenfields Inn")
         -- LATER: find out how this can be done without hard coded numbers
        local position = 8 .. " " .. x .. " " .. y -- 8 is map id
        chr_set_quest(ch, "respawn", position)
    end

    local function start_supply()
        say("I have some supplies for our hideout in the forest, please take "
            .. "it with you when you go there. Just leave the village to the "
            .. "west and go south once you entered the forest.")
        ch:inv_change("Pumpkin", REBEL_FOOD_PUMPKIN,
                        "Food Shank", REBEL_FOOD_FOODSHANK,
                        "Apple", REBEL_FOOD_APPLE)
        chr_set_quest(ch, "rebel_goldenfields_supplies", "started")
    end

    local function collect_taxes()
        local persuaded = false
        say("Hello. How can I help you?")
        local choices = {
            "I'm here to get the outstanding taxes!"
        }
        local res = ask(choices)
        say("Oh, I see. I wonder, do you think those taxes are fair?")
        local choices = {
            "That doesn't matter!",
            "I.. uh.. what do you mean?"
        }
        local res = ask(choices)
        if res == 1 then
            say("I see you're completely brainwashed. Don't you want to "
                .. "think for yourself?")
            local choices = {
                "Are you trying to distract? The taxes!",
                "Yeah, I want to. What's your point?"
            }
            local res = ask(choices)
            if res == 2 then
                say("My point? Well, you don't have to be a brainless "
                    .. "obeying soldier. I can show you something else. "
                    .. "Are you interested?")
                local choices = {
                    "Yes, tell me more.",
                    "I signed a contract when joining the army! "
                    .. "Stop that blabber and give me the taxes."
                }
                local res = ask(choices)
                if res == 1 then
                    persuaded = true
                end
            end
        else
            say("The army squeezes the last money out of the upright citizens, "
                .. "to pay for a war that happens far away, for a king we "
                .. "don't know and who probably never heard that Goldenfields "
                .. "even exists.")
            say("Do you think this is right? "
                .. "Do you really want to support this?")
            local choices = {
                "You're right! I don't want to be part of this. What can I do?",
                "I.. I never looked at it this way.."
            }
            local res = ask(choices)
            if res == 1 then
                persuaded = true
            else
                say("You don't have to stay part of this injustice.")
                local choices = {
                    "And I don't want to!",
                    "But I signed a contract! No, I'll stay loyal. "
                    .. "The taxes, now."
                }
                local res = ask(choices)
                if res == 1 then
                    persuaded = true
                end
            end
        end

        if persuaded then
            say("That's what I wanted to hear, friend! You should talk to "
                .. "Henry. He's hiding in the forest west of Goldenfields, "
                .. "together with some people who share our ideals.")

            start_supply()

            ch:change_reputation("Rebel reputation", 2 * REPUTATION_ONTRIAL + 1) -- remove the malus from completing the tutorial
            ch:change_reputation("Soldier reputation", REPUTATION_RELUCTANT)

            chr_set_quest(ch, "soldier_goldenfields_taxes", "befriended")

            set_respawn()
        else
            say("As you wish. How much do I have to pay?")
            local money = ask_number(GOLDENFIELDS_TAXES - 40,
                                     GOLDENFIELDS_TAXES + 40,
                                     GOLDENFIELDS_TAXES)
            ch:change_money(money)

            chr_set_quest(ch, "soldier_goldenfields_taxes", "gotmoney")
            ch:change_reputation("Rebel reputation",
                                 -10 + math.floor((GOLDENFIELDS_TAXES - money)/10) )
            ch:set_questlog_state(QUESTID_GODWIN_CLAIM_TAXES, QUEST_FINISHED, true)
            ch:set_questlog(QUESTID_GODWIN_RETURN_TAXES, QUEST_OPEN,
                            "Deliver the collected taxes",
                            "Hand the collected taxes to Veteran Godwin.",
                            true)
        end
    end

    local function reputation_dependent()
        local reputation = ch:reputation("Rebel reputation")
        if reputation >= REPUTATION_NEUTRAL then
            say("Hello. Make yourself at home.")
            local supplies = chr_get_quest(ch, "rebel_goldenfields_supplies")
            if supplies == "" then
                local choices = {
                    "Thanks.",
                    "Can I help the rebels in any way?"
                }
                local res = ask(choices)
                if res == 2 then
                    say("I'm glad you made up your mind. "
                        .. "There's indeed something you could do.")
                    start_supply()
                end
            else
                say("Do you need any supplies or clothes? "
                    .. "I can sell you something.")
                trade(false, {
                    { "Pumpkin", 10, 50 },
                    { "Food Shank", 10, 130 },
                    { "Apple", 10, 40 },
                    { "Robe Hood", 10, 400},
                    { "Robe Shirt", 10, 800}
                })
                -- LATER: some more talk, maybe depending on the quest state
            end
        else
            say("With your actions you caused quite some damage to our "
                .. "organization. But we will forget about that if you pay "
                .. "recompensation.")
            local choices = {
                "Ok, what do I have to pay?",
                "No!",
                "What effect would this have?"
            }
            local res = ask(choices)
            if res == 1 then
                apply_amnesty(npc, ch, "Rebel reputation", "Soldier reputation")
                set_respawn()
            elseif res == 3 then
                say("If you pay recompensation for all your actions that "
                    .. "damaged our group, our patrols will stop attacking you "
                    .."on sight, and members of the revolution will be willing "
                    .. "to talk to you.")
                say("But this would be a clear signal that you support our "
                    .. "case, and the army won't like that, "
                    .. "so they'll see you as their enemy.")
                say("So, what's your decision?")
                local choices = {
                    "Ok, how much do I have to pay?",
                    "I don't want to support you."
                }
                local res = ask(choices)
                if res == 1 then
                    apply_amnesty(npc, ch, "Rebel reputation", "Soldier reputation")
                    set_respawn()
                end
            else
                say("Hm. As you wish.")
            end
        end
    end

    local taxes = chr_get_quest(ch, "soldier_goldenfields_taxes")

    if (taxes == "gotorder") then
        collect_taxes()
    else
        reputation_dependent()
    end
    patrol:unblock(ch)
end

local innkeeper = create_npc_by_name("Innkeeper Norman", innkeeper_talk)
innkeeper:set_base_attribute(16, 1)
patrol:assign_being(innkeeper)
schedule_every(21, function() patrol:logic() end)
