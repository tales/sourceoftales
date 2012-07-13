-- authors: Jenalya

local function recruitTalk(npc, ch)
    local function say(message)
        npc_message(npc, ch, message)
    end

    local tutorial_equip = chr_get_quest(ch, "tutorial_equip")
    local tutorial_shop = chr_get_quest(ch, "tutorial_shop")

    say("I'm so exited! I'm going to be a great warrior, fighting in countless battles, until my enemies will shiver in fear as soon as they hear my name.")

    if (tutorial_equip == "done") and (tutorial_shop ~= "done") then
        say("But this armor they give you as recruit is ridiculous! But if you can keep a secret... you can keep a secret, right?")
        say("Blacwin can sell you some of the better armors from the supplies. Just ask him about that. Hey, but it wasn't me who told you about that, ok?")
        chr_set_quest(ch, "tutorial_shop", "done")
    end
    -- idea: could have a friend who later turns out to be one of the rebels
end

local recruit = create_npc_by_name("Recruit Hugh", recruitTalk)
