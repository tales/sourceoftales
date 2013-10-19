--[[

  variable use
  tutorial_fight: save progress on task to fight against the training dummies
       beat_dummies: got task
       done: finished that subquest
  tutorial_equip: saves if got equipment from smith

  Copyright (C) 2012 Jessica Tölke
  Copyright (C) 2013 Przemysław Grzywacz

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

local function instructor_talk(npc, ch)
    local function tutorial()
        local tutorial_fight = chr_get_quest(ch, "tutorial_fight")
        local tutorial_equip = chr_get_quest(ch, "tutorial_equip")
        local tutorial_godwin_talk = chr_get_quest(ch, "tutorial_godwin_talk")

        if tutorial_fight == "beat_dummies" then
            local dummies = ch:kill_count("training dummy")
            if dummies >= TUTORIAL_DUMMY_AMOUNT then
                say("Alright, that looks good. Feel free to train here "
                    .. "whenever you want.")
                chr_set_quest(ch, "tutorial_fight", "done")
                ch:set_questlog_state(QUESTID_TUTORIAL_FIGHT, QUEST_FINISHED, true)
            else
                say("Come on, smash some more of the training dummies.")
            end
        else
            if tutorial_godwin_talk ~= "done" then
                -- player should first talk to godwin!
                say("New recruit? Please report to Veteran Godwin to get your "
                    .. "first assignment. Though he will probably send you back to me to train you...")
                return false
            elseif tutorial_fight == "done" then
                if tutorial_equip ~= "done" then
                    say("You really should get your equipment now. "
                        .. "Talk to Blacwin, the smith.")
                    say("He's a bit grumpy, so don't take it personal if "
                        .. "he doesn't say much.")
                end
            else
                say("Ah, there you are. Welcome to our unit. "
                    .. "I'm going to teach you some basics.")
                if tutorial_equip ~= "done" then
                    say("Didn't you get your equipment yet? Well, whatever, "
                        .. "you can go to Smith Blacwin and get some "
                        .. "armor after the training. Take this for now.")
                else
                    say("Ah, I see you already got your armor. "
                    .. "Here is your weapon.")
                end
                ch:inv_change("Shortsword", 1)
                say ("Alright, now equip it and try it out on some of the "
                    .. "training dummies.")
                chr_set_quest(ch, "tutorial_fight", "beat_dummies")
                ch:set_questlog_description(QUESTID_TUTORIAL_FIGHT,
                    "Enter the training area and kill some dummies.")
            end
        end
        return true
    end

    local function about_attributes()
        say("Attributes define what you are!")
        say("Everybody has the attributes Strength, Agility, Vitality, "
            .. "Intelligence, Dexterity and Willpower.")
        say("Strength affects how strong you can strike.")
        say("Agility makes you move faster. The higher the value the "
            .. "higher the chance to dodge an enemy's attack.")
        say("Vitality determines how fast you regenerate and how much damage "
            .. "you can take.")
        say("Intelligence affects how fast your spells regenerate.")
        say("High values in Dexterity help you to hit enemies more often.")
        say("And finally Willpower. It will make your spells more effective by "
            .. "giving them a higher range or greater effects.")
        say("As soon you raise a level you can distribute points to attributes "
            .. "in the status window.")
    end

    local function about_skills()
        say("Skills are the abilities everyone has. You'll get better with "
            .. "them by just using them.")
        say("Getting more experienced with your skills will enable you to "
            .. "reach a new level and distribute points on your attributes.")
    end

    local function about_specials()
        say("Specials are certain abilities you can learn during your "
            .. "adventure.")
        say("This could be some sword attack, but also spells.")
        say("Keep your eyes open for persons who can teach you new specials.")
    end

    local function about_questions()
        say("Do you have any further questions?")
        local choices = {
            "No, that was all.",
            "What are attributes?",
            "What are skills?",
            "What are specials?"
        }
        local res = ask(choices)
        if res == 2 then
            about_attributes()
            about_questions()
        elseif res == 3 then
            about_skills()
            about_questions()
        elseif res == 4 then
            about_specials()
            about_questions()
        end
    end

    if tutorial() == false then
        -- tutorial was interrupted, don't offer other talk options now
        return
    end

    local reputation = ch:reputation("Soldier reputation")

    if reputation >= REPUTATION_NEUTRAL then
        about_questions()
    elseif reputation > REPUTATION_RELUCTANT then
        say("You shouldn't be here until you recompensed for your misconduct. "
            .. "Talk to Magistrate Eustace in Goldenfields.")
        ch:change_reputation("Soldier reputation", -1)
    else -- reputation <= REPUTATION_RELUCTANT
        say("You dare to come here after what you've done?! "
            .. "You won't have much time to regret this!")
        ch:damage({
            base = 70,
            delta = 20,
            chance_to_hit = 9999
        })
    end
end

local instructor = create_npc_by_name("Instructor Alard", instructor_talk)

