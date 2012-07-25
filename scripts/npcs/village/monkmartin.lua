-- authors: Jenalya

require "scripts/functions/religion"

local function monkTalk(npc, ch)
    local function say(message)
        npc_message(npc, ch, message)
    end

    say("Oh, dear child. Do you have some coins for a mendicant? It'll please the gods.")

    local choices = { "Leave me alone.",
                    "Sure.",
                    "What gods?" }

    local res = npc_choice(npc, ch, choices)

    if res == 1 then
        say("Oh misguided one, Ignis and Aquaria love you nevertheless.")
    elseif res == 2 then
        say("How much do you want to give?")
        local donation = npc_ask_integer(npc, ch, 0, 1000)
        local money = chr_money(ch)
        if money < donation then
            say("You don't have that much.")
        else
            chr_money_change(ch, -donation)
            say("May the blessing of Aquaria grant you new power.")
            being_heal(ch, donation)
            -- TODO: think about more possible effects
            -- idea: value of anger/please for each god
        end
    elseif res == 3 then
        say("I'm shocked! You don't know the gods? Oh poor soul, if you can spare a moment, let me tell you about the "..
            "gods and how our world was created.")
        local choices = { "Nah, I don't have time.",
                        "Ok, tell me." }
        local res = npc_choice(npc, ch, choices)
        if res == 2 then
            creation_myth(npc, ch)
        end
    end
    say("If you wish to gain further knowledge about the gods and the power the can grant "..
        "visit the shrine in Goldenfields.")
end
-- IDEA: run towards players and being_say() things matching to his role?
local monk = create_npc_by_name("Martin", monkTalk)
