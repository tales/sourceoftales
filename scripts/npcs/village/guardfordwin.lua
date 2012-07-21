-- authors: Jenalya

local function guardTalk(npc, ch)
    local function say(message)
        npc_message(npc, ch, message)
    end

    local reputation = tonumber(chr_get_quest(ch, "soldier_reputation"))
    if (reputation == nil) then
        reputation = 0
    end

    if reputation >= REPUTATION_NEUTRAL then
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
    elseif reputation > REPUTATION_RELUCTANT then
        say("To get amnesty for your misconducts talk to Magistrate Eustace in Goldenfields.")
        reputation = reputation - 1
        chr_set_quest(ch, "soldier_reputation", tostring(reputation))
    else -- reputation <= REPUTATION_RELUCTANT
        say("Traitor!")
        being_damage(ch, 80, 10, 9999, DAMAGE_PHYSICAL, ELEMENT_NEUTRAL)
    end
end

local function guardDenyExit(ch)
    if not being_type(ch) == TYPE_CHARACTER then
        return
    end

    local quest = chr_try_get_quest(ch, "tutorial_fight")
    if quest ~= "done" then
        chat_message(ch, "Guard Fordwin: Hey! I can't let you pass like this. Get your equipment and "..
                        "finish your basic training!")
        local x, y = get_named_coordinate("Gate Warp")
        chr_warp(ch, nil, posX(ch), y)
        being_set_direction(ch, DIRECTION_UP)
    end
end

local guard = create_npc_by_name("Guard Fordwin", guardTalk)

create_trigger_by_name("Casern south gate", guardDenyExit)
