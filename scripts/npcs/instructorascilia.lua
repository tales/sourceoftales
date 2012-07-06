local function instructorTalk(npc, ch)
    local function say(message)
        npc_message(npc, ch, message)
    end

    say("TODO.")
    -- tutorial: basic training
    -- equipment, fighting
    -- optional: explain attributes
end

local instructor = npc_create("Instructor Ascilia", 2, GENDER_FEMALE,
                              tileToPixel(37), tileToPixel(92),
                              instructorTalk, nil)
