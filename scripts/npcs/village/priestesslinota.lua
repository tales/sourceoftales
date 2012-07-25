-- authors: Jenalya

require "scripts/functions/religion"

local function priestessTalk(npc, ch)
    local function say(message)
        npc_message(npc, ch, message)
    end

    local function legends()
        say("What would you like me to tell you about?")
        local choices = { "Where do we come from?",
                        "Please tell me about Ignis.",
                        "Can you tell me about Aquaria?",
                        "I'd like to know more about the Third God." }
        local res = npc_choice(npc, ch, choices)
        if res == 1 then
            creation_myth(npc, ch)
        elseif res == 2 then
            ignis_myth(npc, ch)
        elseif res == 3 then
            aquaria_myth(npc, ch)
        else
            thirdgod_myth(npc, ch)
        end
    end

    legends()
end

local priestess = create_npc_by_name("Priestess Linota", priestessTalk)
