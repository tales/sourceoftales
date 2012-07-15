-- authors: Jenalya

local function merchantTalk(npc, ch)
    local function say(message)
        npc_message(npc, ch, message)
    end

    say("Would you like some fresh food? It's delicious and you might be glad about some refreshment after battle.")

    local choices = { "Show me your goods.",
                    "I don't need anything." }

    local res = npc_choice(npc, ch, choices)

    if res == 1 then
        say("TODO: shop with food")
    elseif res == 2 then
        say("As you wish.")
    end
end

local merchant = create_npc_by_name("Anabel", merchantTalk)
