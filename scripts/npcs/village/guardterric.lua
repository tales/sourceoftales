-- authors: Jenalya

local function guardTalk(npc, ch)
    local function say(message)
        npc_message(npc, ch, message)
    end

    local reputation = read_reputation(ch, "soldier_reputation")

    if reputation >= REPUTATION_NEUTRAL then
        say("Oh my, I'm bored. I wish I'd be back in Kingstown.")

        local choices = { "Tell me about Kingstown!",
                        "What's your problem with Goldenfields?",
                        "See you later." }

        local res = npc_choice(npc, ch, choices)

        if res == 1 then
            say("Well, that's a place where you can have fun! It's big, probably much bigger than a country bumpkin "..
                "like you can imagine.")
            say("And it's full of shops where you can anything you can dream of, taverns with the tastiest beer on "..
                "the entire continent! Hah, and if you're looking for a little fight, you won't have a problem "..
                "to find one there.")
            say("Or someone to play a decent game, cards or dice, whatever you want. But you have to watch out for crooks. "..
                "A greenhorn like you would probably get his pockets emptied faster than you can say "..
                "'Long live King Richard!'.")
        elseif res == 2 then
            say("Problem, you say? Hah! This place is a big NOTHING. Endless fields and trees and more fields.")
            say("He sighs.")
            say("And when something happens, it's trouble. Like those agitators who told the village people not "..
                "to pay their taxes. Pah.")
        elseif res ==3 then
            say("Sure.")
        end
    elseif reputation > REPUTATION_RELUCTANT then
        say("To get amnesty for your misconducts talk to Magistrate Eustace.")
        reputation = reputation - 1
        chr_set_quest(ch, "soldier_reputation", tostring(reputation))
    else -- reputation <= REPUTATION_RELUCTANT
        say("Traitor!")
        being_damage(ch, 80, 10, 9999, DAMAGE_PHYSICAL, ELEMENT_NEUTRAL)
    end
end

local guard = create_npc_by_name("Guard Terric", guardTalk)
