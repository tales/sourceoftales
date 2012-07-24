-- authors: Jenalya

local function commanderTalk(npc, ch)
    local function say(message)
        npc_message(npc, ch, message)
    end
    say("What are you doing here? Do you have anything important to report?")
    say("If this is not the case, go back to your duties.")
end

local commander = create_npc_by_name("Commander Ranulf", commanderTalk)
