-- authors: Jenalya

local function recruit_talk(npc, ch)
    local function say(message)
        npc_message(npc, ch, message)
    end
    say("This is nice. Everything is calm and peaceful. "..
        "I mean, we're getting paid for sitting around here, "..
        "drinking and eating. Isn't that wonderful?")
end

local recruit = create_npc_by_name("Recruit Jordan", recruit_talk)

being_set_base_attribute(recruit, 16, 1)
local patrol = Patrol:new("Recruit Jordan")
patrol:assignBeing(recruit)
schedule_every(27, function() patrol:logic() end)
