local function recruitTalk(npc, ch)
    local function say(message)
        npc_message(npc, ch, message)
    end

    say("I'm so exited! I'm going to be a great warrior, fighting in countless battles, until my enemies will shiver in fear as soon as they hear my name.")
    -- idea: could have a friend who later turns out to be one of the rebels
end

local recruit = npc_create("Recruit Hugh", 2, GENDER_MALE,
                              tileToPixel(33), tileToPixel(99),
                              recruitTalk, nil)
