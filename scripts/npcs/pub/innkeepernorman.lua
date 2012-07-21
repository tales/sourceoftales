-- authors: Jenalya

require "scripts/functions/reputation"

local function innkeeperTalk(npc, ch)
    local function say(message)
        npc_message(npc, ch, message)
    end

    local function reputationDependent()
        if reputation >= REPUTATION_NEUTRAL then
            say("Hello.")
            -- TODO: some more talk, maybe depending on the quest state
            -- maybe offer a sleepover in case the player doesn't have full hp
        else
            say("Are you here to make up for the damage you caused? We accept you back if you pay recompensation.")
            local choices = { "Ok, what do I have to pay?",
                            "No!"}
            local res = npc_choice(npc, ch, choices)
            if res == 1 then
                apply_amnesty(npc, ch, "rebel_reputation", "soldier_reputation")
            else
                say("Hm. As you wish.")
            end
        end
    end

    reputation = read_reputation(ch, "rebel_reputation")

    reputationDependent()
end

local innkeeper = create_npc_by_name("Innkeeper Norman", innkeeperTalk)
