-- authors: Jenalya

local function merchantTalk(npc, ch)
    local function say(message)
        npc_message(npc, ch, message)
    end

    say("Welcome to my little shop! I'm sure you're interested in the high quality armor I'm selling. Do you really want to get into a battle with those wastage you got in the casern? Have a look at what I have to offer... it might save your life!")

    local choices = { "Show me your goods.",
                    "I'm not interested." }

    local res = npc_choice(npc, ch, choices)

    if res == 1 then
        say("TODO: shop with equipment")
    elseif res == 2 then
        say("Come back when you change your mind!")
    end
end

local merchant = create_npc_by_name("Gilbert", merchantTalk)
