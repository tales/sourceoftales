-- authors: Jenalya

local function monkTalk(npc, ch)
    local function say(message)
        npc_message(npc, ch, message)
    end

    local function creation_myth()
        say("There are three gods. The god of fire, Ignis, the goddess of water, Aquaria, and the god of earth. "..
            "I won't say his name, because that might call misfortune upon myself.")
        say("It happened that Ignis and Aquaria came together and life was born from their connection. "..
            "Seeing this, the Third God felt rejected and created an empty rock where he hid to be alone with his "..
            "suffering.")
        say("In the meanwhile, Ignis and Aquaria saw that the life they created wasn't able to persist in the void " ..
            "where the gods live. They saw the place that was created by the Third God and ask if their creatures can "..
            "live on it.")
        say("The Third God, still angry, allows this only under the condition that the time they can spend on his "..
            "place is limited. After the creatures' time is over, the Third God will take over the divine power of "..
            "Ignis and Aquaria that made them live and absorb it to strengthen himself.")
        say("Ignis and Aquaria hesitate to accept this demand, since their power would get weaker and weaker over time "..
            "while the Third God would grow. But they love their creations, and can't bring themselves to abandon them. "..
            "So they accept.")
        say("Then something surprising happens. The creatures living on the earth, love back their creators and "..
            "this replenishs Ignis's and Aquaria's power.")
        say("This is why it is important to honor life and worship the gods of Ignis and Aquaria. If the humans ever "..
            "fail to create enough spiritual power to replenish the gods of life, all their energy will be absorbed by "..
            "death one day, and all life will end.")
    end

    say("Oh, dear child. Do you have some coins for a mendicant? It'll please the gods.")

    local choices = { "Leave me alone.",
                    "Sure.",
                    "What gods?" }

    local res = npc_choice(npc, ch, choices)

    if res == 1 then
        say("Oh misguided one, Ignis and Aquaria love you nevertheless.")
    elseif res == 2 then
        say("How much do you want to give?")
        local donation = npc_ask_integer(npc, ch, 0, 1000)
        local money = chr_money(ch)
        if money < donation then
            say("You don't have that much.")
        else
            chr_money_change(ch, -donation)
            say("May the blessing of Aquaria grant you new power.")
            being_heal(ch, donation)
            -- TODO: think about more possible effects
            -- idea: value of anger/please for each god
        end
    elseif res == 3 then
        say("I'm shocked! You don't know the gods? Oh poor soul, if you can spare a moment, let me tell you about the "..
            "gods and how our world was created.")
        local choices = { "Nah, I don't have time.",
                        "Ok, tell me." }
        local res = npc_choice(npc, ch, choices)
        if res == 2 then
            creation_myth()
        end
    end
end

local monk = create_npc_by_name("Martin", monkTalk)
