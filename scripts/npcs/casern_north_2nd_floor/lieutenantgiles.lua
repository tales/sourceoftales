-- authors: Jenalya

local function lieutnantTalk(npc, ch)
    local function say(message)
        npc_message(npc, ch, message)
    end
    say("We're trying to discuss something important here. Go back downstairs.")
end

local lieutnant = create_npc_by_name("Lieutenant Giles", lieutnantTalk)
