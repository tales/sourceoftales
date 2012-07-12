-- authors: Jenalya

local function recruitTalk(npc, ch)
    local function say(message)
        npc_message(npc, ch, message)
    end

    say("Hello " .. being_get_name(ch) .. ". Let's talk a bit.")

    local choices = { "Why did you become a soldier?",
                    "Do you know why they're hiring so many recruits?",
                    "I need to go." }

    local res = npc_choice(npc, ch, choices)

    if res == 1 then
        say("Oh, I just don't want to spent the rest of my life with farm work. You know, I've got so many brothers and sisters, I didn't like the thought to drudge on a dirty farm all my life for my oldest brothers benefit. So I ran away when I was twelve.")
        say("I tramped around the area some while, finding some work to do here and there, but that's a cumbersome life. When I met the recruiter, I decided to rather become I soldier. I'm going to see the world, and maybe I can find some nice place to live after my time of service.")
    elseif res == 2 then
        say("Because of war, you dumbhead. Why else should they even come out here to Goldenfield to hire people? I mean, nothing ever happens here and usually there are only a handful of old soldiers here in the casern who feel bored to death.")
        say("After the basic training we're probably going to be send to more interesting places.")
    elseif res ==3 then
        say("Oh, ok. See you later then.")
    end
end

local recruit = npc_create("Recruit Maurice", 2, GENDER_MALE,
                              tileToPixel(24), tileToPixel(100),
                              recruitTalk, nil)
