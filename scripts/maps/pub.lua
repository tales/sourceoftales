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

local function remove_scullion(npc)

    local npc_position = {posX(npc), posY(npc)}

    local x = npc_position[1]
    x = tostring(x)

    local y = npc_position[2]
    y = tostring(y)

    being_say(npc, x..y)

    if (scullion_position[1] == 336) and (scullion_position[2] == 272) then
        npc_disable(npc)
    end

end

local function create_scullion()
    local function scullionTalk(npc, ch)
        local function say(message)
            npc_message(npc, ch, message)
        end

        say("Sorry for being so rude earlier, but you shouldn't "..
        "be venturing inside the casern. It is way to dangerous, "..
        "even for someone as sneaky as you. All this has really "..
        "stressed me out, how about you get me a drink and we'll "..
        "call it quits?")

        local choices = {"Well of course, let us talk.",
                    "I don't see why I would spend a dime for you."}
        local res = npc_choice(npc, ch, choices)

        if res == 1 then
            local check_for_beer = chr_inv_count(ch, true, true,
                "Pint of beer")
            if check_for_beer < 1 then
                say("I think Norman sells some great homebrews. "..
                    "If it's available, you should try his "..
                    "wonderfull Scotch Ale, or even his "..
                    "Imperial Stout. Even though it would never "..
                    "beat 'Le trou du diable'!")

            elseif check_for_beer >= 1 then
                chr_inv_change(ch, "Pint of beer", -1)
                say("Ahhh, this feels much better. So what do you "..
                    "want from me exactly?")
                being_say(ch, "I hear you may be interested in "..
                                    "helping out the Rebels, \nbut we "..
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


            end

        elseif res == 2 then


            test = {"This", "is", "a", "test"}

            for i,v in ipairs(test) do
                say(v)
            end

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
                    npc_disable(npc)
                end
            end)



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
