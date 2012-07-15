-- authors: Jenalya

local function girlTalk(npc, ch)
    local function say(message)
        npc_message(npc, ch, message)
    end
    -- wants into the casern, pretends to be a bit stupid and to have romantic ideas about soldiers
    -- but actually works for the rebels and wants to gather information
    -- could be a contact person for later rebel quests
end

local girl = create_npc_by_name("Emma", girlTalk)
