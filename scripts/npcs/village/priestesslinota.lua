--[[

  Priestess Linota

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

require "scripts/functions/religion"

-- LATER: eventually change which spells are given when once we add more content


local function priestess_talk(npc, ch)
    local legends_choices = {
        "Where do we come from?",
        "Please tell me about Ignis.",
        "Can you tell me about Aquaria?",
        "I'd like to know more about the Third God.",
        "Thank you."
    }
    local legends_answers = {1, 2, 3, 4, 5}

    local function remove_answer(answers, num)
        for i,v in ipairs(answers) do
            if num == v then
                table.remove(answers, i)
                break
            end
        end
    end

    local function legends()
        function dialogue_creation()
            local creation_text = creation_myth()
                for i,v in ipairs(creation_text) do
                    say(v)
                end
            legends_choices[1] = nil
            remove_answer(legends_answers, 1)
            return legends()
        end

        function dialogue_ignis()
            local ignis_text = ignis_myth()
            for i,v in ipairs(ignis_text) do
                say(v)
            end
            legends_choices[2] = nil
            remove_answer(legends_answers, 2)
            return legends()
        end

        function dialogue_aquaria()
            local aquaria_text = aquaria_myth()
            for i,v in ipairs(aquaria_text) do
                say(v)
            end
            legends_choices[3] = nil
            remove_answer(legends_answers, 3)
            return legends()
        end

        function dialogue_thirdgod()
            local thirdgod_text = thirdgod_myth()
            for i,v in ipairs(thirdgod_text) do
                say(v)
            end
            legends_choices[4] = nil
            remove_answer(legends_answers, 4)
            return legends()
        end

        say("Is there something specific you'd like to know about them?")

        local res = ask(legends_choices)

        res = legends_answers[res]

        if res == 1 then
            return dialogue_creation()
        elseif res == 2 then
            return dialogue_ignis()
        elseif res == 3 then
            return dialogue_aquaria()
        elseif res == 4 then
            return dialogue_thirdgod()
        elseif res == 5 then
            local quest = chr_get_quest(ch, "goldenfields_shrine")
            if quest ~= "done" then
                return priestess_talk(npc, ch)
            end
        end
    end

    local function explain_specials()
        say("To access your divine powers, press the button marked with a "
            .. "star. To use a spell, click on it. "
            .. "After you used it, you'll have to wait a while until you "
            .. "can ask your god for help again.")
            --LATER: change when client has shortcuts
    end

    local function questions()
        say("Is there anything else I can help you with?")
        local choices = {
            "No, I'm all right.",
            "I have some question about the gods.",
            "Can you explain me how to use specials?"
        }
        local res = ask(choices)

        if res == 2 then
            legends()
        elseif res == 3 then
            explain_specials()
        end
    end


    local function get_followUp()
        say("For the sake of the worlds balance, please explore where "
            .. "the skeletons in the cave come from. "
            .. "We need to stop this!")
        say("Did you find anything that can help us to get more "
            .. "information about the undeads?")
        local artifact = ch:inv_count("Unholy Crystals")
        if artifact > 0 then
            local choices = {
                "Yes, I found this strange artifact.",
                "Not yet."
            }
            local res = ask(choices)
            if res == 1 then
                artifact = ch:inv_count("Unholy Crystals")
                if artifact > 0 then
                    ch:inv_change("Unholy Crystals", -1)
                    say("Let me see...")
                    say("This is... very alarming. The order needs to be "
                        .. "informed about that. I'll write a letter "
                        .. "explaining what we found out.")
                    say("Once the path above the mountains is open again, "
                        .. "please bring this letter to the shrine of "
                        .. "Mountains Watch north of here.")
                        -- LATER: remove the part about closed path after we
                        -- added more content
                    say("Your journey might be dangerous, so I'll grant "
                        .. "you further knowledge in the gods powers.")
                    local magic = chr_get_quest(ch, "magic")
                    chr_set_quest(ch, "goldenfields_shrine", "done")
                    if magic == "fire" then
                        ch:give_special("Magic_Fire Lion")
                        say("You now have the ability to call a fiery lion "
                            .. "upon your opponent.")
                    elseif magic == "water" then
                        ch:give_special("Magic_Insult")
                        say("Use your new ability to get your opponents "
                            .. "attention. You can use this to protect your "
                            .. "fellows.")
                    elseif magic == "earth" then
                        ch:give_special("Magic_Earthquake")
                        say("Let the earth shake around you to inflict "
                            .. "damage on your enemies.")
                    end
                else
                    say("Where is this artifact you were talking about? "
                        .. "Show it to me.")
                end
            elseif res == 2 then
                return questions()
            end
        end
    end

    local function get_magic()
        local quest = chr_get_quest(ch, "goldenfields_shrine")
        -- this is to check if the function was called from the main
        -- talk function, or from get_quest because of the skeleton
        -- killcount
        if quest == "skeletonspotted" then
            say("Welcome back. Did you see any skeletons?")
            local choices = {
                "Yes! In the caves! They attacked me!",
                "The rumors were true, I found skeletons in "
                .. "the cave."
            }
            local res = ask(choices)
            if res == 1 then
                say("I thank the gods you're save! It was irresponsible from "
                    .. "me to send you there without proper protection.")
            end
        end
        say("Oh, this are terrible news you're bringing. Listen, this "
            .. "means someone found a way to prevent the soul's power to be "
            .. "taken by The Third God. This is a sacrilege against the gods!")
        say("As I said, there are records about a similiar thing happening "
            .. "a long while ago... ah, if I'd only remember what exactly "
            .. "it said. I read about it during my apprenticeship for "
            .. "priesthood.")
        say("I think you showed that you're worth the gods blessing, so "
            .. "I'm going to teach you how to use some of the "
            .. "powers they can grant us. Which god do you feel closest to?")
        local choices = {
            "Ignis, the god of flames and warriors!",
            "Aquaria, the goddess of water and healing.",
            "The Third God, dedicated to death and earth."
        }
        local res = ask(choices)
        chr_set_quest(ch, "goldenfields_shrine", "getartifact")
        if res == 1 then
            ch:give_special("Magic_Lightning")
            chr_set_quest(ch, "magic", "fire")
            say("Now you can ask Ignis to strike your enemy with lightning.")
        elseif res == 2 then
            ch:give_special("Magic_Heal")
            chr_set_quest(ch, "magic", "water")
            say("You now have the ability to heal your wounds with the "
                .. "aid of Aquaria.")
        else
            ch:give_special("Magic_Snake Bite")
            chr_set_quest(ch, "magic", "earth")
            say("Now you can call The Third God's servants to bite your "
                .. "enemy.")
        end

        explain_specials()
        say("I see you're a brave warrior. Can I ask you to help me "
            .. "once again, and explore the caves for some hint "
            .. "that could help us to figure out what's behind this? It "
            .. "could be some kind of artifact, something related to earth.")
        say("It might be dangerous, but the spell I taught you should "
            .. "help you to protect yourself.")
    end

    local function start_quest()
        say("Magic is a blessing from our gods. As a priestess, I "
            .. "could asks the gods to recognize you and "
            .. "aid you with their powers.")
        say("But this shouldn't be done frivolously, so I won't do "
            .. "that until I know you're worthy this blessing.")
        local choices = {
            "How can I prove that I'm worthy?",
            "Nevermind then."
        }
        local res = ask(choices)
        if res == 1 then
            say("There's something important I need to find out, but "
                .. "I shouldn't leave the shrine unless there's "
                .. "an emergency. You could prove yourself by going "
                .. "instead. But I warn you, it could be dangerous.")
            say("If this doesn't discourage you, I'll explain you "
                .. "the issue.")
            local choices = {
                "I'm not afraid!",
                "Dangerous? I changed my mind."
            }
            local res = ask(choices)
            if res == 1 then
                say("Very well. I heard alarming rumors about ... "
                    .. "walking skeletons in the caves north of here. "
                    .. "This sounds indeed very strange, but there are "
                    .. "old records which tell about a similiar thing "
                    .. "happening a long time ago.")
                say("I need to know if these rumors are true.")
                say("Please investigate the northern caves and find "
                    .. "out if there really are walking skeletons. "
                    .. "You can find an entrance north west of the "
                    .. "casern. And be careful.")
                chr_set_quest(ch, "goldenfields_shrine", "started")
                local skeleton_killcount =
                    ch:kill_count("Skeleton Mage")
                    + ch:kill_count("Skeleton")
                    + ch:kill_count("Skeleton Soldier")
                if skeleton_killcount > 0 then
                    local choices = {
                        "I already visited the caves. "
                        .. "The rumors are true."
                    }
                    local res = ask(choices)
                    return get_magic()
                else
                    return priestess_talk(npc, ch)
                end
            elseif res == 2 then
                return priestess_talk(npc, ch)
            end
        elseif res == 2 then
            return priestess_talk(npc, ch)
        end
    end

    local function initial_talk()
        say("Welcome to the Goldenfields shrine. Do you seek the gods?")
        local choices = {
            "Yes, please tell me about them.",
            "I'd like to learn magic.",
            "I have to go."
        }
        local res = ask(choices)
        if res == 1 then
            legends()
        elseif res == 2 then
            start_quest()
        end
    end


    local quest = chr_get_quest(ch, "goldenfields_shrine")

    if quest == "done" then
        say("Welcome back. I'm sure the priests in Mountains Watch will "
            .. "know what to do about the skeletons.")
        say("Would you like to hear about our gods?")
        local choices = {
            "Not at the moment.",
            "Sure!",
            "Can you explain again how to use specials?"
        }
        local res = ask(choices)
        if res == 2 then
            return legends()
        elseif res == 3 then
            return explain_specials()
        end
    elseif quest == "getartifact" then
        return get_followUp()
    elseif quest == "skeletonspotted" then
        return get_magic()
    elseif quest == "started" then
        say("Please investigate the northern caves and find out if the "
            .. "rumors about walking skeletons are true.")
        return questions()
    else
        return initial_talk()
    end
end

local priestess = create_npc_by_name("Priestess Linota", priestess_talk)
