-- [[
-- Durmak. Is afraid of bees. He offers a repeatable quest to defeat bees.
--
-- Global variables:
-- + bee_quest_char -- Tracks the char that does the bee quest at the moment.
-- Authors:
-- + Ablu
-- ]]

local bee_quest_doable = true

local function durmarkTalk(npc, ch)
    local function say(message)
        npc_message(npc, ch, message)
    end

    local function quest(key)
        return chr_get_quest(ch, key)
    end

    local function set_quest(key, value)
        chr_set_quest(ch, key, value)
    end

    local reward = false
    if quest("goldenfields_durmark_bees") == "reward" then
        reward = true
    end

    local function aboutLife()
        say("Yes. I was born here and have lived my entire life here.")
        say("I will never leave this place. I do not like the big cities. " ..
            "This small village is exactly where i want to live.")
    end

    local function aboutVillage()
        say("Hm. Sure my friend.")
        say("This village was a collection of some farmer's houses for a long time. " ..
            "A couple of houses were built around these farms. ")
        say("Somewhere they built a pub. You should definetly check it out! " ..
            "Always good to keep up to date.")
        say("It was a nice circle of people. Everbody knew each other and met and conversed.")
        say("Then the country house up there in the north west of the village became a barrack.")
        say("We never really had contact to the king out here. " ..
            "But one day we had his patrols on our street.")
        say("They suddenly started to collect taxes and recruiting people for the army.")
        say("Well back to the village... The casern provided new ways to make money.")
        say("Merchants travel to our village quite often now. " ..
            "With them news from everywhere out of the kingdom.")
        say("I prefer to stay away from this hustle and bustle.")
        say("Check out the market. But be aware. Those merchants will rip you off!")
        say("Ahw the good old days...")
    end

    local function aboutDoing()
        say("I am only walking around the village. I enjoy the nature.")
        say("Here I am far away from the frenzy of activity in the village.")
    end

    local function aboutProblems()
        if bee_quest_char == nil and bee_quest_doable and not reward then
            say("Actually Yes! I nearly got attacked by a big bee swarm. " ..
                "TODO: hint position")
            say("You look like a fighter. Can you clear out the bees? " ..
                "They somehow went insane.")
            local choices = { "Sure i will!",
                              "Not at the moment. Sorry!" }
            res = npc_choice(npc, ch, choices)
            if res == 1 then
                bee_quest_char = ch
                -- Reset quest at map change or logout
                on_remove(ch, function()
                    if bee_quest_char == ch then
                        chr_create_text_particle(bee_quest_char, "You failed the Bee Quest.")
                    end
                end)
                schedule_in(30 * 60, function()
                    if bee_quest_char == ch then
                        chr_create_text_particle(bee_quest_char,
                                                 "You took to long for the Bee Quest")
                        bee_quest_char = nil
                    end
                end)

                say("Good to hear my friend! I will see if i can give you a small reward later.")
            else
                say("Too bad. Maybe someone else can help me then.")
            end
        else
            say("No. At the moment I am happy.")
        end
    end

    local function aboutReward()
        say("Ah! Thank you a lot!")
        set_quest("goldenfields_durmark_bees", "")
        set_quest("goldenfields_durmark_bees_counter",
            (tonumber(quest("goldenfields_durmark_bees_counter")) or 0) + 1)
        say("Hm. Here take this. It is not much but it might be useful for you!")
        chr_money_change(ch, 100)
        say("Thanks a lot for your help.")
    end

    say("Hello my friend.")
    local choices = { "Do you live here?",
                      "What are you doing here?",
                      "Bye." }
    if reward then
        table.insert(choices, 3, "I killed the bees.")
    end

    local res = npc_choice(npc, ch, choices)
    if res == 1 then
        aboutLife()
        choices = { "Why do you not like the big cities?",
                    "Can you tell me more about this village?",
                    "Ha? Living in this village? Sound pretty pointless to me!" }

        res = npc_choice(npc, ch, choices)
        if res == 1 then
            say("Good question my friend. I have never been in a big city so far. " ..
                "I cannot tell you what i do not like about them. But I like it here!")
        elseif res == 2 then
            aboutVillage()
            local choices = { "Are there any other problems that bother you apart of the merchants?",
                              "Thanks for the information! Good bye." }
            res = npc_choice(npc, ch, choices)
            if res == 1 then
                aboutProblems()
            end
        else
            say("Do not bother me then!")
        end
    elseif res == 2 then
        aboutDoing()
    elseif reward and res == 3 then
        aboutReward()
    end
end

local bee_counter = 0
local bee_spawn_trigger_position = {}

local function init()
    local objects = map_get_objects("TRIGGER")
    for _, object in ipairs(objects) do
        if object:name() == "Bee trigger" then
            local x, y, w, h = object:bounds()
            bee_spawn_trigger_position.x = x + w / 2
            bee_spawn_trigger_position.y = y + h / 2
            return
        end
    end
    assert("No \"Bee trigger\" found")
end 
init()

local function beeRemove()
    bee_counter = bee_counter - 1
    if bee_counter == 0 then
        if get_distance(posX(bee_quest_char), posY(bee_quest_char),
                        bee_spawn_trigger_position.x, bee_spawn_trigger_position.y) < 20 * TILESIZE then
            chr_set_quest(bee_quest_char, "goldenfields_durmark_bees", "reward")
            chr_create_text_particle(bee_quest_char, "Finished bee quest! Talk to Durmark for a reward.")
            bee_quest_char = nil
            bee_quest_doable = false -- start delay
            bess_got_spawned = false
            schedule_in(30 * 60, function() bee_quest_doable = true end)
        end
    end
end

local bees_got_spawned = false

local function beeTrigger(being)
    if being == bee_quest_char and not bees_got_spawned then
        local x, y = posX(being), posY(being)
        for i=1,10 do
            local bee = monster_create("Bee", x + math.random(-4 * TILESIZE, 4 * TILESIZE),
                                       y + math.random(-4 * TILESIZE, 4 * TILESIZE))
            on_remove(bee, beeRemove)
            monster_change_anger(bee, bee_quest_char, 1)
            bee_counter = bee_counter + 1
        end
        bees_got_spawned = true
    end
end

local durmark = create_npc_by_name("Durmark", durmarkTalk)
local bee_trigger = create_trigger_by_name("Bee trigger", beeTrigger)
