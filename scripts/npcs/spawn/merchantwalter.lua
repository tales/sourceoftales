-- authors: Jenalya

local function merchantTalk(npc, ch)
    local function say(message)
        npc_message(npc, ch, message)
    end
    -- sells potions
end

local merchant = create_npc_by_name("Walter", merchantTalk)
