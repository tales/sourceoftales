-- authors: Jenalya

local function guardTalk(npc, ch)
    local function say(message)
        npc_message(npc, ch, message)
    end
    say("TODO")
end

local guard = create_npc_by_name("Guard Hamond", guardTalk)
