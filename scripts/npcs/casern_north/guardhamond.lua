-- authors: Jenalya

local function guardTalk(npc, ch)
    local function say(message)
        npc_message(npc, ch, message)
    end
    say("You can find the quarters, the canteen and the kitchen on this floor.")
    say("The upper floor is where the higher ranks live, meet and eat. "..
        "Better don't go there, unless you're told to. They might get angry.")
end

local guard = create_npc_by_name("Guard Hamond", guardTalk)
