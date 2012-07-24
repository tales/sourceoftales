-- authors: Jenalya

local function lieutnantTalk(npc, ch)
    local function say(message)
        npc_message(npc, ch, message)
    end
    say("Oh? What are you doing here? This area is only for the higher ranks.")
end

local lieutnant = create_npc_by_name("Lieutenant Bennet", lieutnantTalk)
