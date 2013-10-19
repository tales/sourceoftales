--[[

  Smith Blacwin

  variable use
  tutorial_equip: saves if got equipment from smith

  Copyright (C) 2012 Erik Schilling
  Copyright (C) 2012 Jessica Tölke
  Copyright (C) 2013 Przemysław Grzywacz

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

local patrol = NPCPatrol:new("Smith Blacwin")

local function smith_talk(npc, ch)
    patrol:block(ch)

    local function chat()
        local tutorial_equip = chr_get_quest(ch, "tutorial_equip")
        local tutorial_shop = chr_get_quest(ch, "tutorial_shop")
        if tutorial_equip ~= "done" then
            say("Yes?")
            local ask_equip = {
                "I need my equipment!",
                "Nevermind."
            }
            local res = ask(ask_equip)
            if res == 1 then
                say("Here.")
                ch:inv_change("Kettle hat", 1)
                ch:inv_change("Rusty chain armor", 1)
                chr_set_quest(ch, "tutorial_equip", "done")
                ch:set_questlog_state(QUESTID_TUTORIAL_EQUIP, QUEST_FINISHED, true)
                local reply_equip = {
                    "You're not very talkative, are you?",
                    "Thanks."
                }
                local res = ask(reply_equip)
                if res == 1 then
                    say("No.")
                else
                    say("Hm.")
                end
            else
                say("Hmph.")
            end
        else
            say("Hrm.")
            if tutorial_shop == "done" then
                local ask_shop = {
                    "I heard you could sell me better armor?",
                    "Nevermind."
                }
                local res = ask(ask_shop)
                if res == 1 then
                    trade(false, {
                        { "Iron Helmet", 10, 1800 },
                        { "Iron Armor", 10, 6000 },
                        { "Iron Gloves", 10, 1000 },
                        { "Chain Hood", 10, 1600 }
                    })
                else
                    say("Hmph.")
                end
            end
        end
    end

    local reputation = ch:reputation("Soldier reputation")

    if reputation >= REPUTATION_NEUTRAL then
        chat()
    elseif reputation > REPUTATION_RELUCTANT then
        say("Go away until you've talked to Magistrate Eustace.")
        ch:change_reputation("Soldier reputation", -1)
    else -- reputation <= REPUTATION_RELUCTANT
        say("Argh!")
        ch:damage({
            base = 120,
            delta = 10,
            chance_to_hit = 9999
        })
    end
    patrol:unblock(ch)
end

local smith = create_npc_by_name("Smith Blacwin", smith_talk)
smith:set_base_attribute(16, 1)
patrol:assign_being(smith)
schedule_every(12, function() patrol:logic() end)

