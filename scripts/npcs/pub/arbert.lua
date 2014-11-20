--[[

  Arbert
  Home: House 5
  Relationships: employer of Thomas, Joseph, Peter and Francis

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

local patrol = NPCPatrol:new("Arbert")

local function man_talk(npc, ch)
    patrol:block(ch)

    local BEETLE_AMOUNT = 8
    local helpfarmers = chr_get_quest(ch, "soldier_goldenfields_helpfarmers")

    if (helpfarmers == "meet") then
        say("You are a soldier! Are you here to help me with the beetle problem?")
        local choices = {
            "That's what I came for.",
            "No, I'm here to relax and spend my hard earned pay."
        }
        local res = ask(choices)
        if (res == 1) then
            say("Finally! It's about time they do something. "
                .. "With all the increased taxes and so many young people joining the army "
                .. "we can hardly gather enough to make a living.")
            say("Do you know what another poor harvest will do to me? It'll ruin me! I tell you! "
                .. "Those greedy army and their king will take everything I have left and leave me to starve!")
            local choices = {
                "Calm down and tell me how to help you.",
                "Get to the point. The beetles?"
            }
            ask(choices)
            say("Impatient! However, the beetles, yes. "
                .. "There are just to many of them. When we plant new seeds, "
                .. "they will nibble the young plants, making them wither away. ")
            say("My workers are currently preparing a field for the next sowing. "
                .. "I want you to reduce the number of beetles before we do that, "
                .. "so we at least have a chance for some harvest.")
            say("Show me at least " .. BEETLE_AMOUNT .. " dead beetles as a prove that you did your job properly.")
            ch:set_questlog_description(QUESTID_GODWIN_HELPFARMERS,
                "Slay some beetles on the fields and show Arbert " .. BEETLE_AMOUNT .. " dead beetles as a proof.", true)
            chr_set_quest(ch, "soldier_goldenfields_helpfarmers", "hunt")
        else
            say("Pah! Hard earned? Don't make me laugh.")
        end
    elseif (helpfarmers == "hunt") then
        beetle_count = ch:inv_count("Beetle Corpus")
        if beetle_count >= BEETLE_AMOUNT then
            chr_set_quest(ch, "soldier_goldenfields_helpfarmers", "helped")
            ch:set_questlog_description(QUESTID_GODWIN_HELPFARMERS,
                "Report back to Veteran Godwin.", true)
            say("You did it! What a relief. Thank you.")
            local choices = {
                "Don't you want the dead beetles?"
            }
            ask(choices)
            say("Ew, why would I? I just asked to see them so I can be sure you did your job.")
            say("You know, I heard from some casern staff that the chef back in the caserns "
                .. "likes to use all kind of weird stuff for his recipes.")
            say("Maybe you can get him interested in those.")

        else
            say("Show me at least " .. BEETLE_AMOUNT .. " dead beetles as a prove that you did your job properly.")
        end
    else
        say("Do you see Borin over there? He's always drunk...")
        say("One day, he was so drunk that he fell into the pond "
            .. "in front of the pub's entrance when he left.")
        say("That was funny, I tell you! Well, he nearly drowned, "
            .. "but Norman was able to pull him out soon enough.")
    end

    patrol:unblock(ch)
end

local man = create_npc_by_name("Arbert", man_talk)
man:set_base_attribute(16, 1)
patrol:assign_being(man)
schedule_every(17, function() patrol:logic() end)
