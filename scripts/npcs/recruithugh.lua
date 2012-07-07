local function recruitTalk(npc, ch)
    local function say(message)
        npc_message(npc, ch, message)
    end

    say("TODO.")
    -- has naive ideas about being a soldier, wants to earn fame in heroic battles
    -- idea: could have a friend who later turns out to be one of the rebels
end

local recruit = npc_create("Recruit Hugh", 2, GENDER_MALE,
                              tileToPixel(33), tileToPixel(99),
                              recruitTalk, nil)
