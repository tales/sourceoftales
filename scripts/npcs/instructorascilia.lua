local function instructorTalk(npc, ch)
    local function say(message)
        npc_message(npc, ch, message)
    end

    say("TODO.")
    -- tutorial: basic training
    -- equipment, fighting
    -- optional: explain attributes
end

-- TODO: change sprite
local instructor = npc_create("Instructor Ascilia", 1, GENDER_FEMALE,
                              tileToPixel(37), tileToPixel(92),
                              instructorTalk, nil)
