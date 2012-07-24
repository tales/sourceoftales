-- authors: Jenalya

local function recruitTalk(npc, ch)
    local function say(message)
        npc_message(npc, ch, message)
    end
    say("This is nice. Everything is calm and peaceful. "
        "I mean, we're getting paid for sitting around here, drinking and eating. Isn't that wonderful?")
end

local recruit = create_npc_by_name("Recruit Jordan", recruitTalk)
