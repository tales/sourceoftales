--[[

  Widow Isabella
  Home: House 2
  Relationships: Widow of Lief, mother of Hamond (not living in Goldenfields)

  Copyright (C) 2012 Jessica Tölke
  Copyright (C) 2014 Jessica Beller

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

local patrol = NPCPatrol:new("Widow Isabella")

local function woman_talk(npc, ch)
    patrol:block(ch)
    local function pumpkin_quest()
        say("Welcome to my house. Did you come here to cheer up an old "
            .. "and lonely woman?")
        local choices = {
            "Sorry, I don't have time to chat.",
            "You are lonely?"
        }
        local res = ask(choices)
        if res == 2 then
            say("Yes, my beloved husband Lief died three years and four "
                .. "months ago.")
            say("And our only son Hamond decided to leave Goldenfields, "
                .. "and so I'm all alone here.")
            say("Ah, I miss them. It feels as if it was just yesterday "
                .. "that I made the pumpkin bread they loved so much. "
                .. "Dear, when was the last time that I ate pumpkin bread? "
                .. "I don't remember...")
            local pumpkin = ch:inv_count("Pumpkin")
            if pumpkin > 0 then
                local choices = {
                    "I'm very sorry for you.",
                    "I have a pumpkin with me... would you like it?"
                }
                local res = ask(choices)
                if res == 1 then
                    say("Ah...")
                else
                    pumpkin = ch:inv_count("Pumpkin")
                    if pumpkin > 0 then
                        ch:inv_change("Pumpkin", -1)
                        chr_set_quest(ch, "goldenfields_widow", "done")
                        ch:change_money(100)
                        say("Oh, how kind of you! I'm going to bake pumpkin "
                            .. "bread, just like in the old times. Thank you!")
                    else
                        say("Really? Oh, but where is it? Don't make fun "
                            .. "of a sad old woman!")
                    end
                end
            end
        end
    end

    local quest = chr_get_quest(ch, "goldenfields_widow")

    if quest == "done" then
        say("Hello my dear. Thank you for brining me the pumpkin, "
            .. "that was really kind of you.")
    else
        pumpkin_quest()
    end
    patrol:unblock(ch)
end

local woman = create_npc_by_name("Widow Isabella", woman_talk)

woman:set_base_attribute(16, 1)
patrol:assign_being(woman)
schedule_every(42, function() patrol:logic() end)
