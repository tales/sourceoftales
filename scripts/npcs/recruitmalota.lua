local function recruitTalk(npc, ch)
    local function say(message)
        npc_message(npc, ch, message)
    end

    say ("[Recruit Malota]")
    say("\"Hello " .. being_get_name(ch) .. ". Let's talk a bit.\"")

    local choices = { "Why did you become a soldier?",
                    "Do you know why they're hiring so many recruits?",
                    "I need to go." }

    local res = npc_choice(npc, ch, choices)

    if res == 1 then
        say("\"Oh, I just don't want to spent the rest of my life with farm work. \"")
    elseif res == 2 then
        say("\".\"")
    elseif res ==3 then
        say("\"Oh, ok. See you later then.\"")
    end
    -- her family owns a farm, she has many siblings
    -- doesn't want to spend her life with farm work, wants to see the world
end

local recruit = npc_create("Recruit Malota", 2, GENDER_FEMALE,
                              tileToPixel(24), tileToPixel(100),
                              recruitTalk, nil)
