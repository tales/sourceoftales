--[[

  Durmak. Is afraid of bees. He offers a repeatable quest to defeat bees.
  Home: House 3
  Relationships: -

  Global variables:
  + bee_quest_char -- Tracks the char that does the bee quest at the moment.

  Copyright (C) 2012 Erik Schilling

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see <http://www.gnu.org/licenses/>.

--]]

local patrol = NPCPatrol:new("Durmark")

local bee_quest_doable = true

local function durmark_talk(npc, ch)
    patrol:block(ch)

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

    local function about_life()
        say("Yes. I was born here and have lived my entire life here.")
        say("I plan to never leave this place. I do not like the big cities. " ..
            "This small village is exactly where i want to live.")
    end

    local function about_village()
        say("Hm. Sure, my friend.")
        say("For a long time, this village was a mere collection of farmhouses. " ..
            "Later, a couple more houses were built around the farms. ")
        say("They also built a pub. You should definitely check it out! " ..
            "It's always good to keep up to date.")
        say("It was a nice circle of people. Everbody knew each other, and they often met and socialized.")
        say("But that changed when the country house in the northwest of the village became a barracks.")
        say("We had never really had contact with the king out here before, " ..
            "but one day we had his patrols on our street.")
        say("They suddenly started to collect taxes and recruit people for the army.")
        say("Well, back to the village... The barracks provided new ways to make money.")
        say("Merchants travel to our village quite often now. " ..
            "They bring news from everywhere in the kingdom, and beyond.")
        say("Myself, I prefer to stay away from all the hustle and bustle.")
        say("Check out the market. But be aware. Those merchants will rip you off!")
        say("Ah, the good old days...")
    end

    local function about_doing()
        say("I'm just walking around the village. I enjoy being in nature.")
        say("Here, I am far away from the frenzy of activity in the village.")
    end

    local function about_problems()
        if bee_quest_char == nil and bee_quest_doable and not reward then
            say("Actually Yes! I nearly got attacked by a big bee swarm when I walked around south west of the market "..
                "place. There are some tree stumps, maybe they have their nest in one of them.")
            say("You look like a fighter. Can you clear out the bees? " ..
                "They somehow went insane.")
            local choices = { "Sure I will!",
                              "Not at the moment. Sorry!" }
            res = ask(choices)
            if res == 1 then
                ch:set_questlog(QUESTID_DURMARK_BEES, QUEST_OPEN, "Bzzzzzz",
                                "Find the bee swarm which nearly attacked Durmark and kill the bees.\n "
                                .. "He assumes the swarm has its nest in one of the tree stumps.")
                bee_quest_char = ch
                -- Reset quest at map change or logout
                on_remove(ch, function()
                    if bee_quest_char == ch then
                        bee_quest_char = nil
                        ch:set_questlog_status(QUESTID_DURMARK_BEES, QUEST_FAILED)
                    end
                end)
                schedule_in(30 * 60, function()
                    if bee_quest_char == ch then
                        bee_quest_char = nil
                        ch:set_questlog_status(QUESTID_DURMARK_BEES, QUEST_FAILED)
                    end
                end)

                say("Good to hear my friend! But be careful, there were quite a lot of them. If they're too many "..
                    "take a friend with you. I will see if i can give you a small reward later.")
            else
                say("Too bad. Maybe someone else can help me then.")
            end
        else
            say("No. At the moment I am happy.")
        end
    end

    local function about_reward()
        say("Ah! Thank you a lot!")
        set_quest("goldenfields_durmark_bees", "")
        set_quest("goldenfields_durmark_bees_counter",
            (tonumber(quest("goldenfields_durmark_bees_counter")) or 0) + 1)
        say("Hm. Here take this. It is not much but it might be useful for you!")
        ch:change_money(100)
        say("Thanks a lot for your help.")
    end

    say("Hello my friend.")
    local choices = { "Do you live here?",
                      "What are you doing here?",
                      "Bye." }
    if reward then
        table.insert(choices, 3, "I killed the bees.")
    end

    local res = ask(choices)
    if res == 1 then
        about_life()
        choices = { "Why don't you like big cities?",
                    "Can you tell me more about this village?",
                    "Ha? Living in this village? Sounds pretty pointless to me!" }

        res = ask(choices)
        if res == 1 then
            say("Good question, my friend. I have never actually been in a big city so far. " ..
                "So I cannot tell you exactly what I do not like about them. But I know that I like it here!")

        elseif res == 2 then
            about_village()
            local choices = { "Are there any other problems that bother you apart of the merchants?",
                              "Thanks for the information! Good bye." }
            res = ask(choices)
            if res == 1 then
                about_problems()
            end
        else
            say("Do not bother me then!")
        end
    elseif res == 2 then
        about_doing()
    elseif reward and res == 3 then
        about_reward()
    end
    patrol:unblock(ch)
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

local function bee_remove()
    bee_counter = bee_counter - 1
    if bee_counter == 0 then
        if (bee_quest_char ~= nil) and (get_distance(bee_quest_char:x(), bee_quest_char:y(),
                        bee_spawn_trigger_position.x, bee_spawn_trigger_position.y) < 20 * TILESIZE) then
            chr_set_quest(bee_quest_char, "goldenfields_durmark_bees", "reward")
            bee_quest_char:set_questlog_state(QUESTID_DURMARK_BEES, QUEST_FINISHED)
        end

        -- Reset so quest can be done again in 30 minutes
        bee_quest_char = nil
        bee_quest_doable = false -- start delay
        schedule_in(30 * 60, function() bee_quest_doable = true end)
    end
end

local function bee_trigger(being)
    if being == bee_quest_char and bee_quest_doable then
        local x, y = being:position()
        for i=1,10 do
            local bee = monster_create("Bee", x + math.random(-4 * TILESIZE, 4 * TILESIZE),
                                       y + math.random(-4 * TILESIZE, 4 * TILESIZE))
            on_remove(bee, bee_remove)
            bee:change_anger(bee_quest_char, 1)
            bee_counter = bee_counter + 1
        end
        bee_quest_doable = false
    end
end

local durmark = create_npc_by_name("Durmark", durmark_talk)
local bee_trigger = create_trigger_by_name("Bee trigger", bee_trigger)
durmark:set_base_attribute(16, 1)
patrol:assign_being(durmark)
schedule_every(10, function() patrol:logic() end)
