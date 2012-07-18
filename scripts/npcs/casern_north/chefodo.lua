-- authors: Jenalya

local function chefTalk(npc, ch)
    local function say(message)
        npc_message(npc, ch, message)
    end
    say("TODO")
end

local chef = create_npc_by_name("Chef Odo", chefTalk)
