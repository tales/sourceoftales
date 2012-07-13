-- authors: Jenalya

local function guardTalk(npc, ch)
    local function say(message)
        npc_message(npc, ch, message)
    end

    say("This merchants are worse than blowflies! If I don't pay attention for a moment, they'll sneak into the casern to distract the new recruits with their goods.")
end

local function guardDenyExit(ch)
    -- check for the amount of dummies, because quest variables can't be checked here, as this is threaded
    local dummies = chr_get_kill_count(ch, "training dummy")
    if dummies < 6 then
        chat_message(ch, "Guard Fordwin: Hey! I can't let you pass like this. Get your equipment and finish your basic training!")
        chr_warp(ch, nil, posX(ch), tileToPixel(117))
        being_set_direction(ch, DIRECTION_UP)
    end
end

local guard = npc_create("Guard Fordwin", 3, GENDER_MALE,
                              tileToPixel(49), tileToPixel(119),
                              guardTalk, nil)

trigger_create(tileToPixel(45), tileToPixel(118), 4*32, 1*32, guardDenyExit, 0, true)
