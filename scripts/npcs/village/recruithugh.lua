-- authors: Jenalya

local function recruitTalk(npc, ch)
    local function say(message)
        npc_message(npc, ch, message)
    end

    local reputation = read_reputation(ch, "soldier_reputation")

    if reputation >= REPUTATION_NEUTRAL then
        local tutorial_equip = chr_get_quest(ch, "tutorial_equip")
        local tutorial_shop = chr_get_quest(ch, "tutorial_shop")

        say("I'm so exited! I'm going to be a great warrior, fighting in countless battles, until my enemies will "..
            "shiver in fear as soon as they hear my name.")

        if (tutorial_equip == "done") and (tutorial_shop ~= "done") then
            say("But this armor they give you as recruit is ridiculous! But if you can keep a secret... you can keep "..
                "a secret, right?")
            say("Blacwin can sell you some of the better armors from the supplies. Just ask him about that. "..
                "Hey, but it wasn't me who told you about that, ok?")
            chr_set_quest(ch, "tutorial_shop", "done")
        end
        -- idea: could have a friend who later turns out to be one of the rebels
    elseif reputation > REPUTATION_RELUCTANT then
        say("Wow, you really got into trouble, heh? Why are you here? Shouldn't you talk to Magistrate Eustace?")
        reputation = reputation - 1
        chr_set_quest(ch, "soldier_reputation", tostring(reputation))
    else -- reputation <= REPUTATION_RELUCTANT
        say("Ah! Don't hurt me! Go away!")
        being_damage(ch, 50, 10, 9999, DAMAGE_PHYSICAL, ELEMENT_NEUTRAL)
    end

end

local recruit = create_npc_by_name("Recruit Hugh", recruitTalk)
