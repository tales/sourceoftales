-- authors: Jenalya

local function veteranTalk(npc, ch)
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

        say("Now go, talk to Instructor Ascilia, so she can show you how you can avoid being speared by the first "..
            "enemy you'll encounter.")
        say("Oh, and get your equipment from Blacwin. You should at least look like a soldier.")
        say ("Come back to me when you're done.")
    end

    local reputation = tonumber(chr_get_quest(ch, "soldier_reputation"))
    if (reputation == nil) then
        reputation = 0
    end

    if reputation >= REPUTATION_NEUTRAL then
        local tutorial_fight = chr_get_quest(ch, "tutorial_fight")
        local tutorial_equip = chr_get_quest(ch, "tutorial_equip")
        if (tutorial_fight ~= "done") or (tutorial_equip ~= "done") then
            send_tutorial()
        else
            say("TODO: quest after tutorial and more")
        end
    elseif reputation > REPUTATION_RELUCTANT then
        say("Why are you here? Talk to Magistrate Eustace to get amnesty from your crimes!")
        reputation = reputation - 1
        chr_set_quest(ch, "soldier_reputation", tostring(reputation))
    else -- reputation <= REPUTATION_RELUCTANT
        say("I can't deny you're brave, but that won't help you now!")
        being_damage(ch, 90, 30, 9999, DAMAGE_PHYSICAL, ELEMENT_NEUTRAL)
    end

end
-- TODO: add start equipment in global_events.lua, on_chr_birth
-- initialize reputation values in on_chr_birth or here?
-- idea for later quest: get taxes from the inhabitants in Goldenfields

local veteran = create_npc_by_name("Veteran Godwin", veteranTalk)
