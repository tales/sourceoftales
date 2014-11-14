--[[

  Emma
  Home: House 7
  Relationships: Daughter of Thea, niece of Emma

  Copyright (C) 2012 Jessica Tölke

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

    -- wants into the casern, pretends to be a bit stupid and to have romantic ideas about soldiers
    -- but actually works for the rebels and wants to gather information
    -- could be a contact person for later rebel quests

local patrol = NPCPatrol:new("Emma")

local function girl_talk(npc, ch)
    patrol:block(ch)

    local function persuade_soldier()
        say("Ouh, that guard over there is sooo mean to me.")

        local choices = {
            "What did he do?",
            "I don't have time for this nonsense."
        }
        local res = ask(choices)
        if res == 1 then
            say("He won't let me enter the casern! That's not nice!")
            local choices = {
                "Why do you want to go into the casern?",
                "That's not mean, that's correct!"
            }
            local res = ask(choices)
            if res == 1 then
                say("I just want to see it! And I want to visit the soldiers. "
                    .. "You're all sooo brave and strong!")
            else
                say("Oh you, don't say that!")
            end
            say("Wouldn't you want me to visit you in the casern? Yes? "
                .. "Pleeease tell the guard to let me enter.")
            local choices = {
                "I don't think he'll listen to me.",
                "You can't enter the casern!"
            }
            local res = ask(choices)
            if res == 1 then
                say("Oh, please try. Pleeease.")
                chr_set_quest(ch, "rebels_emmas_camouflage", "ask")
            else
                say("Ouh.")
            end
        elseif res == 2 then
            say("Oh, you're mean too!")
        end
    end

    -- LATER: add a check if the player is rebel or soldier
    -- this here is for the case the player is soldier:
    local emma = chr_get_quest(ch, "rebels_emmas_camouflage")
    if emma == "" then
        persuade_soldier()
    elseif emma == "ask" then
        say("Did you talk to the guard? Can I see the casern? "
            .. "That'd be soooo sweet.")
    elseif emma == "deny" then
        say("So? What did the guard say? Can I enter the casern now?")
        local choices = {
            "No, he's stubborn on that."
        }
        local res = ask(choices)
        say("Ah, at least you tried.")
        chr_set_quest(ch, "rebels_emmas_camouflage", "done")
    elseif emma == "done" then
        say("Soldiers are so exciting.")
        -- LATER: ask questions depending on the quest state
        -- to 'spy' on the player
    end
    patrol:unblock(ch)
end

local girl = create_npc_by_name("Emma", girl_talk)
girl:set_base_attribute(16, 1)
patrol:assign_being(girl)
schedule_every(11, function() patrol:logic() end)
