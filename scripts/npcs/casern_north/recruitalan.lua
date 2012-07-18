-- authors: Jenalya

local function recruitTalk(npc, ch)
    local function say(message)
        npc_message(npc, ch, message)
    end
    say("TODO")
end

local recruit = create_npc_by_name("Recruit Alan", recruitTalk)
