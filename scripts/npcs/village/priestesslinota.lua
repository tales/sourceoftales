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

local function priestessTalk(npc, ch)
    local function say(message)
        npc_message(npc, ch, message)
    end

    local function legends()
        say("Is there something specific you'd like to know about them?")
        local choices = { "Where do we come from?",
                        "Please tell me about Ignis.",
                        "Can you tell me about Aquaria?",
                        "I'd like to know more about the Third God." }
        local res = npc_choice(npc, ch, choices)
        if res == 1 then
            creation_myth(npc, ch)
        elseif res == 2 then
            ignis_myth(npc, ch)
        elseif res == 3 then
            aquaria_myth(npc, ch)
        else
            thirdgod_myth(npc, ch)
        end
    end

    local function initialTalk()
        say("Welcome to the Goldenfields shrine. Do you seek the gods?")
        local choices = { "Yes, please tell me about them.",
                        "I'd like to learn magic.",
                        "I have to go." }
        local res = npc_choice(npc, ch, choices)
        if res == 1 then
            legends()
        elseif res == 2 then
            say("Magic is a blessing from our gods. As a priestess, I could asks the gods to recognize you and "..
                "aid you with their powers.")
            say("But this shouldn't be done frivolously, so I won't do that until I know you're worthy this blessing.")
            local choices = { "How can I prove that I'm worthy?",
                        "Nevermind then." }
            local res = npc_choice(npc, ch, choices)
            if res == 1 then
                say("There's something important I need to find out, but I shouldn't leave the shrine unless there's "..
                    "an emergency. You could prove yourself by going instead. But I warn you, it could be dangerous.")
                say("If this doesn't discourage you, I'll explain you the issue.")
                local choices = { "I'm not afraid!",
                                "Dangerous? I changed my mind." }
                local res = npc_choice(npc, ch, choices)
                if res == 1 then
                    say("Very well. I heard alarming rumors about ... walking skeletons in the caves north of here. "..
                        "This sounds indeed very strange, but there are old records which tell about"..
                        "a similiar thing happening a long time ago.")
                    say("I need to know if these rumors are true.")
                    say("Please investigate the northern caves and find out if there really are walking skeletons. "..
                        "And be careful.")
                    chr_set_quest(ch, "goldenfields_shrine", "started")
                end
            end
        end
    end

    local function getMagic()
        say("Welcome back. Did you see any skeletons?")
        local choices = { "Yes! In the caves! They attacked me!",
                        "The rumors were true, I found skeletons on the cave." }
        local res = npc_choice(npc, ch, choices)
        if res == 1 then
            say("I thank the gods you're save! It was irresponsible from me to send you there without proper protection.")
        end
        say("Oh, this are terrible news you're bringing. Listen, this means someone found a way to prevent the "..
            "soul's power to be taken by The Third God. This is a sacrilege against the gods!")
        say("As I said, there are records about a similiar thing happening a long while ago... ah, if I'd only remember "..
            "what exactly it said. I read about it during my apprenticeship for priesthood.")
        say("I think you showed that you're worth the gods blessing, so I'm going to teach you how to use some of the "..
            "powers they can grant us.")
        chr_give_special(ch, "Magic_Fire Lion")
        chr_give_special(ch, "Magic_Heal")
        chr_set_quest(ch, "goldenfields_shrine", "getartifact")
        say("TODO: explain how to use specials")
        say("I see you're a brave warrior. Can I ask you to help me once again, and explore the caves for some hint "..
            "that could help us to figure out what's behind this? It could be some kind of artifact, something "..
            "related to earth.")
        say("It might be dangerous, but the spells I taught you should help you to protect yourself.")
    end

    local function getFollowUp()
        say("Did you find anything that can help us to get more information about the undeads?")
        local artifact = chr_inv_count(ch, true, false, "Unholy Crystals")
        if artifact > 0 then
            local choices = { "Yes, I found this strange artifact.",
                            "Not yet."}
            local res = npc_choice(npc, ch, choices)
            if res == 1 then
                artifact = chr_inv_count(ch, true, false, "Unholy Crystals")
                if artifact > 0 then
                    chr_inv_change(ch, "Unholy Crystals", -1)
                    say("Let me see...")
                    say("This is... very alarming. The order needs to be informed about that. I'll write a letter "..
                        "explaining what we found out.")
                    say("Once the path above the mountains is open again, please bring this letter to the shrine of "..
                        "Mountains Watch north of here.")
                        -- LATER: remove the part about closed path after we added more content
                    say("Your journey might be dangerous, so I'll grant you further knowledge in the gods powers.")
                    chr_give_special(ch, "Magic_Earthquake")
                    chr_give_special(ch, "Magic_Lightning")
                    chr_give_special(ch, "Magic_Snake Bite")
                    chr_set_quest(ch, "goldenfields_shrine", "done")
                else
                    say("Where is this artifact you were talking about? Show it to me.")
                end
            end
        end
    end

    local quest = chr_get_quest(ch, "goldenfields_shrine")

    if quest == "done" then
        say("Welcome back. I'm sure the priests in Mountains Watch will know what to do about the skeletons.")
        say("Would you like to hear about our gods?")
        local choices = { "Not at the moment.",
                        "Sure!"}
        local res = npc_choice(npc, ch, choices)
        if res == 2 then
            legends()
        end
    elseif quest == "gotartifact" then
        getFollowUp()
    elseif quest == "getartifact" then
        say("For the sake of the worlds balance, please explore where the skeletons in the cave come from. "..
            "We need to stop this!")
    elseif quest == "skeletonspotted" then -- TODO: check trigger position once the entrance is fixed
        getMagic()
    elseif quest == "started" then
        say("Please investigate the northern caves and find out if the rumors about walking skeletons are true.")
    else
        initialTalk()
    end
end

local priestess = create_npc_by_name("Priestess Linota", priestessTalk)
