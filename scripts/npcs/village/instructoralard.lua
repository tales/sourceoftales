-- authors: Jenalya

-- variable use
-- tutorial_fight: save progress on task to fight against the training dummies
--      beat_dummies: got task
--      done: finished that subquest
-- tutorial_equip: saves if got equipment from smith

local function instructorTalk(npc, ch)
    local function say(message)
        npc_message(npc, ch, message)
    end
    local function fightTrainingSoldier()
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

    local tutorial_fight = chr_get_quest(ch, "tutorial_fight")
    local tutorial_equip = chr_get_quest(ch, "tutorial_equip")
    if tutorial_fight == "beat_dummies" then
        local dummies = chr_get_kill_count(ch, "training dummy")
        if dummies >= tutorial_dummy_amount then
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
            fightTrainingSoldier()
        end
    end
    say("Do you have any further questions?")
    say("TODO: add some topics, e.g. attributes, skills etc")
end

local instructor = create_npc_by_name("Instructor Alard", instructorTalk)
