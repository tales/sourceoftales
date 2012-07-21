-- authors: Jenalya

local function recruitTalk(npc, ch)
    local function say(message)
        npc_message(npc, ch, message)
    end

    local function chat()
        say("Hello " .. being_get_name(ch) .. ". Let's talk a bit.")

        local choices = { "Why did you become a soldier?",
                        "Do you know why they're hiring so many recruits?",
                        "I need to go." }

        local res = npc_choice(npc, ch, choices)

        if res == 1 then
            say("Oh, I just don't want to spent the rest of my life with farm work. You know, I've got so many brothers "..
                "and sisters, I didn't like the thought to drudge on a dirty farm all my life for my oldest brothers "..
                "benefit. So I ran away when I was twelve.")
            say("I tramped around the area some while, finding some work to do here and there, but that's a cumbersome "..
                "life. When I met the recruiter, I decided to rather become I soldier. I'm going to see the world, and "..
                "maybe I can find some nice place to live after my time of service.")
        elseif res == 2 then
            say("Because of war, you dumbhead. Why else should they even come out here to Goldenfields to hire people? "..
                "I mean, nothing ever happens here and usually there are only a handful of old soldiers here in the "..
                "casern who feel bored to death.")
            say("After the basic training we're probably going to be send to more interesting places.")
            say("At least I hope so. If those rebels become a more serious problem, they might need use here.")

            local choices = { "Well, thanks for the information.",
                            "Rebels? What do you mean?"}

            local res = npc_choice(npc, ch, choices)

            if res == 2 then
                say("Didn't you hear? Some people got upset about the increased taxes and started rioting. So far they "..
                    "didn't seem very organized, but I heard rumors that they're getting more successful.")
            end
        elseif res == 3 then
            say("Oh, ok. See you later then.")
        end
    end

    local reputation = tonumber(chr_get_quest(ch, "soldier_reputation"))
    if (reputation == nil) then
        reputation = 0
    end

    if reputation >= REPUTATION_NEUTRAL then
        chat()
    elseif reputation > REPUTATION_RELUCTANT then
        say("To get amnesty for your misconducts talk to Magistrate Eustace.")
        reputation = reputation - 1
        chr_set_quest(ch, "soldier_reputation", tostring(reputation))
    else -- reputation <= REPUTATION_RELUCTANT
        say("Traitor!")
        being_damage(ch, 80, 10, 9999, DAMAGE_PHYSICAL, ELEMENT_NEUTRAL)
    end

end

local recruit = create_npc_by_name("Recruit Maurice", recruitTalk)
