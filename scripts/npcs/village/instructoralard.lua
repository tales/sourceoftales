--[[

  variable use
  tutorial_fight: save progress on task to fight against the training dummies
       beat_dummies: got task
       done: finished that subquest
  tutorial_equip: saves if got equipment from smith

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

local function instructorTalk(npc, ch)
    local function say(message)
        npc_message(npc, ch, message)
    end

    local function tutorial()
        local tutorial_fight = chr_get_quest(ch, "tutorial_fight")
        local tutorial_equip = chr_get_quest(ch, "tutorial_equip")

        if tutorial_fight == "beat_dummies" then
            local dummies = chr_get_kill_count(ch, "training dummy")
            if dummies >= TUTORIAL_DUMMY_AMOUNT then
                say("Alright, that looks good. Feel free to train here whenever you want.")
                chr_set_quest(ch, "tutorial_fight", "done")
            else
                say("Come on, smash some more of the training dummies.")
            end
        else
            if tutorial_fight == "done" then
                if tutorial_equip ~= "done" then
                    say("You really should get your equipment now. Talk to Blacwin, the smith.")
                    say("He's a bit grumpy, so don't take it personal if he doesn't say much.")
                end
            else
                say("Ah, there you are. Welcome to our unit. I'm going to teach you some basics.")
                if tutorial_equip ~= "done" then
                    say("Didn't you get your equipment yet? Well, whatever, you can go to Smith Blacwin and get some "..
                        "armor after the training. Take this for now.")
                else
                    say("Ah, I see you already got your armor. Here is your weapon.")
                end
                chr_inv_change(ch, "Shortsword", 1)
                say ("Alright, now equip it and try it out on some of the training dummies.")
                chr_set_quest(ch, "tutorial_fight", "beat_dummies")
            end
        end
    end

    local function aboutAttributes()
        say("Attributes define what you are!")
        say("Everybody has the attributes Strenght, Agility, Vitality, " ..
            "Intelligence, Dexterity and Willpower")
        say("Strength affects how strong you can strike.")
        say("Agility how fast you can move. The higher the value the higher the " ..
            "chance to dodge an enemy attack is.")
        say("Vitality is how good you heal and how much damage you can take.")
        say("Intelligence affects how fast your spells regenerate.")
        say("High values in Dexterity help you to hit enemys more often.")
        say("And finally Willpower. It will make your spells more effective by " ..
            "giving them a higher range or greater effects.")
        say("As soon you raise a level you can distribute points to attributes " ..
            "in the status window.")
    end

    local function aboutSkills()
        say("TODO")
    end

    local function aboutSpecials()
        say("TODO")
    end

    local function aboutQuestions()
        say("Do you have any further questions?")
        local choices = {
            "What are attributes?",
            "What are skills?",
            "What are specials?",
            "No that was all."
        }
        local res = npc_choice(npc, ch, choices)
        if res == 1 then
            aboutAttributes()
            aboutQuestions()
        elseif res == 2 then
            aboutSkills()
            aboutQuestions()
        elseif res == 3 then
            aboutSpecials()
            aboutQuestions()
        end
    end

    tutorial()

    local reputation = read_reputation(ch, "soldier_reputation")

    if reputation >= REPUTATION_NEUTRAL then
        aboutQuestions()
    elseif reputation > REPUTATION_RELUCTANT then
        say("You shouldn't be here until you recompensed for your misconduct. Talk to Magistrate Eustace in Goldenfields.")
        reputation = reputation - 1
        chr_set_quest(ch, "soldier_reputation", tostring(reputation))
    else -- reputation <= REPUTATION_RELUCTANT
        say("You dare to come here after what you've done?! You won't have much time to regret this!")
        being_damage(ch, 70, 20, 9999, DAMAGE_PHYSICAL, ELEMENT_NEUTRAL)
    end
end

local instructor = create_npc_by_name("Instructor Alard", instructorTalk)
