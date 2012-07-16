-- authors: Jenalya

local function guardTalk(npc, ch)
    local function say(message)
        npc_message(npc, ch, message)
    end

    say("These merchants are worse than blowflies! If I don't pay attention for a moment, they'll sneak "..
        "into the casern to distract the new recruits with their goods.")

    local emma = chr_get_quest(ch, "rebels_emmas_camouflage")
    if emma == "ask" then
        local choices = { "That girl, Emma, could you let her enter?",
                        "Then I won't distract you."}
        local res = npc_choice(npc, ch, choices)
        if res == 1 then
            say("What, now she started to ask soldiers to beg for her? That girl drives me insane.")
            say("Listen, this is an army. This isn't the place to fool around. No civilians in the casern.")
            chr_set_quest(ch, "rebels_emmas_camouflage", "deny")
        end
    end
end

local function guardDenyExit(ch)
    if not being_type(ch) == TYPE_CHARACTER then
        return
    end

    -- check for the amount of dummies, because quest variables can't be checked here, as this is threaded
    local dummies = chr_get_kill_count(ch, "training dummy")
    if dummies < TUTORIAL_DUMMY_AMOUNT then
        chat_message(ch, "Guard Fordwin: Hey! I can't let you pass like this. Get your equipment and "..
                        "finish your basic training!")
        chr_warp(ch, nil, posX(ch), tileToPixel(117))
        being_set_direction(ch, DIRECTION_UP)
    end
end

local guard = create_npc_by_name("Guard Fordwin", guardTalk)

create_trigger_by_name("Casern south gate", guardDenyExit)
