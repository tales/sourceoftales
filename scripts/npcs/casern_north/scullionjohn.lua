-- authors: Jenalya

local function scullionTalk(npc, ch)
    local function say(message)
        npc_message(npc, ch, message)
    end
    say("TODO")
end

local scullion = create_npc_by_name("Scullion John", scullionTalk)
