-- authors: Jenalya

local function recruitTalk(npc, ch)
    local function say(message)
        npc_message(npc, ch, message)
    end
    say("Ah, I'm bored. There wasn't much going on since I arrived here. "..
        "I hope those rebels will stir some trouble, a decent fight would be fun by now.")
end

local recruit = create_npc_by_name("Recruit Alan", recruitTalk)
