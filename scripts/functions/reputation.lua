-- author: Jenalya

function is_valid_faction(faction)
    -- TODO: make this more flexible, probably with something like this: http://www.lua.org/pil/13.1.html
    -- factions = {"soldier_reputation", "rebel_reputation"}
    if faction == "soldier_reputation" or faction == "rebel_reputation" then
        return true
    else
        return false
    end
end

function read_reputation(ch, faction)
    local reputation = 0
    if is_valid_faction(faction) then
        reputation = tonumber(chr_get_quest(ch, faction))
        if (reputation == nil) then
            reputation = 0
            chr_set_quest(ch, faction, tostring(reputation))
        end
    end
    return reputation
end

function apply_amnesty(npc, ch, friendlyfaction, foefaction)
    local function say(message)
        npc_message(npc, ch, message)
    end

    local reputation = read_reputation(ch, friendlyfaction)
    local foe_reputation = read_reputation(ch, foefaction)

    local cost = - reputation -- TODO: formula
    say("You have to pay " .. cost .. " GP to make up for your crimes.")

    say("Do you accept?")
    local choices = { "Yes, here it is.",
                    "That's too much."}
    local res = npc_choice(npc, ch, choices)
    if res == 1 then
        local money = chr_money(ch)
        if money >= cost then
            chr_money_change(ch, -cost)
            reputation = 0
            foe_reputation = foe_reputation - cost -- TODO: formula
            say("I hope you learned from your mistakes.")
        else
            say("Come back when you can afford it.")
        end
    else
        say("Mh. Come back when you changed your mind.")
    end

    chr_set_quest(ch, friendlyfaction, tostring(reputation))
    chr_set_quest(ch, foefaction, tostring(foe_reputation))
end
