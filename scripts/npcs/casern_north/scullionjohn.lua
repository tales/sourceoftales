-- authors: Jenalya

local function scullionTalk(npc, ch)
    local function say(message)
        npc_message(npc, ch, message)
    end
    say("Psh, don't distract me! I need to wash the carrots and peel the potatoes. Then I have to cut the mushrooms.")
    say("Chef Odo will get angry if I'm not fast enough!")
end

local scullion = create_npc_by_name("Scullion John", scullionTalk)
