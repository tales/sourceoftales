-- authors: Jenalya

local function girlTalk(npc, ch)
    local function say(message)
        npc_message(npc, ch, message)
    end

    local function persuadeSoldier()
        say("Ouh, that guard over there is sooo mean to me.")

        local choices = { "What did he do?",
                        "I don't have time for this nonsense." }
        local res = npc_choice(npc, ch, choices)
        if res == 1 then
            say("He won't let me enter the casern! That's not nice!")
            local choices = { "Why do you want to go into the casern?",
                            "That's not mean, that's correct!" }
            local res = npc_choice(npc, ch, choices)
            if res == 1 then
                say("I just want to see it! And I want to visit the soldiers. You're all sooo brave and strong!")
            else
                say("Oh you, don't say that!")
            end
            say("Wouldn't you want me to visit you in the casern? Yes? Pleeease tell the guard to let me enter.")
            local choices = { "I don't think he'll listen to me.",
                            "You can't enter the casern!" }
            local res = npc_choice(npc, ch, choices)
            if res == 1 then
                say("Oh, please try. Pleeease.")
                chr_set_quest(ch, "rebels_emmas_camouflage", "ask")
            else
                say("Ouh.")
            end
        elseif res == 2 then
            say("Oh, you're mean too!")
        end
    end

    -- TODO: add a check if the player is rebel or soldier
    -- this here is for the case the player is soldier:
    local emma = chr_get_quest(ch, "rebels_emmas_camouflage")
    if emma == "" then
        persuadeSoldier()
    elseif emma == "ask" then
        say("Did you talk to the guard? Can I see the casern? That'd be soooo sweet.")
    elseif emma == "deny" then
        say("So? What did the guard say? Can I enter the casern now?")
        local choices = { "No, he's stubborn on that."}
        local res = npc_choice(npc, ch, choices)
        say("Ah, at least you tried.")
        chr_set_quest(ch, "rebels_emmas_camouflage", "done")
    elseif emma == "done" then
        say("TODO: ask questions about the army, depending on the quest state")
    end
end

local girl = create_npc_by_name("Emma", girlTalk)

    -- wants into the casern, pretends to be a bit stupid and to have romantic ideas about soldiers
    -- but actually works for the rebels and wants to gather information
    -- could be a contact person for later rebel quests
