-- authors: Jenalya

local function monkTalk(npc, ch)
    local function say(message)
        npc_message(npc, ch, message)
    end
    -- mendicant, promises you the blessing of the gods if you give him money
    -- could maybe heal the player
    -- TODO: think about more possible effects
    -- idea: value of anger/please for each god
end

local monk = create_npc_by_name("Martin", monkTalk)


-- Belief system:
-- Male god of fire/power/war/sun: Orthar
-- Female goddess of water/growth/moon: Emerea
-- god of death/justice: Larry/Bobby (?) (his name is seldomly used because people think it gives bad luck)
