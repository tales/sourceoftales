-- authors: Jenalya

local function merchantTalk(npc, ch)
    local function say(message)
        npc_message(npc, ch, message)
    end

    say("Potions! Do you feel ill? Do you need some explosives to protect yourself? Or do you want to boost your abilities for battle? I have everything you can imagine, and even more! Have a look!")

    local choices = { "Show me your goods.",
                    "I'm fine." }

    local res = npc_choice(npc, ch, choices)

    if res == 1 then
        say("TODO: shop with potions")
    elseif res == 2 then
        say("I hope you won't have to regret that!")
    end
end

local merchant = create_npc_by_name("Walter", merchantTalk)
