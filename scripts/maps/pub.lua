--[[

  Goldenfields Inn.

  Copyright (C) 2012 Jessica Tölke
  Copyright (C) 2012 Philippe Groarke

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

local patrol = Patrol:new("Scullion John")
schedule_every(3, function() patrol:logic() end)


local function create_scullion()
    local refused_beer = false
        local scullion_choices = {"Let us talk.",
                            "I don't see why I would spend a dime "..
                            "for you."}

    local function scullionTalk(npc, ch)
        local function say(message)
            npc_message(npc, ch, message)
        end

        chr_set_quest(ch, "rebelphilip_mole", "step1")

        local function dialogue_give_quest()
            say("Ahhh, this feels much better. So what do you "..
                "want from me exactly?")
            being_say(ch, "I hear you may be interested in "..
                                "helping out the Rebels, but we "..
                                "need to confirm you are trustworthy.")

            say("Yes, I've had plenty of time to see how the army "..
                "treats this village. They are unworthy of our taxes "..
                "and shouldn't be here!")
            say("I am not a fighter, nor much "..
                "of a loud mouth for that, but I can gather "..
                "information for you and your group. I hear many "..
                "things working in the kitchens...")

            local dummy_reply = {"Take a sip of beer."}
            local dummy_reply = npc_choice(npc, ch, dummy_reply)
            being_say(ch, "This is interesting, please continue.")

            say("Don't tell anybody I told you, but I've "..
                "heard rumors the King's councellor is angry "..
                "about this towns uprising. He may even come here "..
                "to assess the situation!")
            say("The king sent him a "..
                "letter to fix the rendez-vous and its location. "..
                "The patrol was just about to leave when I came "..
                "here. Maybe you could intercept them...")

            being_say(ch, "I will do just that! No time to "..
                            "alert my superior. He will be happy I've "..
                            "taken an initiative... I think?")
            say("The patrol was heading into the mountains. Good "..
                "luck! And be sure to mention my help to your "..
                "leader.")
            chr_set_quest(ch, "rebelphilip_mole", "step2")

            --TODO: make him walk away
            patrol:unassign_being(npc)
            being_walk(npc, 336, 144)
            being_walk(npc, 272, 144)
            being_walk(npc, 336, 240)
            being_walk(npc, 336, 272)

            schedule_every(2, function()
                local x = posX(npc)
                local y = posY(npc)
                --debug stuff
                local xstring = tostring(x)
                local ystring = tostring(y)
                being_say(npc, xstring..ystring)

                if (x == 336) and (y == 272) then
                    --npc_disable(npc)
                end
            end)
        end

        local function dialogue_refused_beer()
            say("So...")
            local more_beer_choices = {"Here they are..."}
            local res = npc_choice(npc, ch, more_beer_choices)
                if check_for_beer < 2 then
                    say("I'm waiting.")

                elseif check_for_beer >= 2 then
                    chr_inv_change(ch, "Pint of beer", -2)
                    dialogue_give_quest()
                end
        end

        if refused_beer then
            dialogue_refused_beer()

        else
            say("Sorry for being so rude earlier, but you shouldn't "..
            "be venturing inside the casern. It is way to dangerous, "..
            "even for someone as sneaky as you. All this has really "..
            "stressed me out, how about you get me a drink and we'll "..
            "call it quits?")

            local res = npc_choice(npc, ch, scullion_choices)

            if res == 1 then
                local check_for_beer = chr_inv_count(ch, true, true,
                    "Pint of beer")
                if (check_for_beer < 1) then
                    say("I think Norman sells some great homebrews. "..
                        "If it's available, you should try his "..
                        "wonderfull Scotch Ale, or even his "..
                        "Imperial Stout. Even though it would never "..
                        "beat 'Le trou du diable'!")

                elseif check_for_beer >= 1 then
                    chr_inv_change(ch, "Pint of beer", -1)
                    dialogue_give_quest()
                end

            elseif res == 2 then
                say("Oh really? I've been working hard in the kitchen "..
                    "all day. I could have been fired, or even worst, "..
                    "if I was caught talking to you, and you can't even "..
                    "spare a few dimes!?")

                local refused_beer_choices = {"I'm sorry, what was I "..
                                            "thinking?",
                                            "Tough luck! You aren't getting "..
                                            "anything from me."}
                local res = npc_choice(npc, ch, refused_beer_choices)
                if res == 1 then
                    table.remove(scullion_choices, 2)
                    dialogue_give_quest()
                elseif res == 2 then
                    say("What was I thinking. There is no way I will work "..
                        "with someone like you! I'm out of here!")

                    patrol:unassign_being(npc)
                    being_walk(npc, 336, 144)
                    being_walk(npc, 272, 144)
                    being_walk(npc, 336, 240)
                    being_walk(npc, 336, 272)

                    being_say(ch, "W-w-wait! I can't let you go, my "..
                            "superior would be very angry...")


                    being_say(npc, "Ah ha! Very funny.")
                    being_say(ch, "I'm very honest. I'll buy you two "..
                        "beers then!")

                    say("Hmmm, that is a generous offer. Ok then, "..
                        "I'll talk. You can buy some beer from "..
                        "Innkeeper Norman.")
                    table.remove(scullion_choices, 2)
                    refused_beer = true
                end

            end
        end

    end

    local scullion = create_npc_by_name("Scullion John", scullionTalk)

    being_set_base_attribute(scullion, 16, 2)
    patrol:assign_being(scullion)

end

local function rebelphilip_mole(being,id)
    if being_type(being) ~= TYPE_CHARACTER then
        return
    end

    local quest_mole = chr_try_get_quest(being, "rebelphilip_mole")
    if (quest_mole == "step1") and (#patrol.members < 1) then
        create_scullion()

    --debug
    elseif (quest_mole == "step2") and (#patrol.members < 1) then
    create_scullion()
    end
end

atinit(function()
    require "scripts/functions/npchelper"
    parse_npcs_from_map()

    require "scripts/functions/npcpatrol"

    require "scripts/functions/triggerhelper"
    require "scripts/npcs/pub/arbert"
    require "scripts/npcs/pub/innkeepernorman"
    require "scripts/npcs/pub/borin"

    parse_triggers_from_map()
    create_trigger_by_name("rebelphilip mole quest", rebelphilip_mole)

end)
