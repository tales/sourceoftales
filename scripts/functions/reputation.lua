--[[

  Reputation related scripts

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

function is_valid_faction(faction)
    -- TODO: make this more flexible, probably with something like this:
    -- http://www.lua.org/pil/13.1.html
    -- factions = {"soldier_reputation", "rebel_reputation"}
    if faction == "soldier_reputation" or faction == "rebel_reputation" then
        return true
    else
        return false
    end
end

function read_reputation(ch, faction)
    local reputation = 0
    if is_valid_faction(faction) then
        reputation = tonumber(chr_try_get_quest(ch, faction))
        if (reputation == nil) then
            reputation = 0
            chr_set_quest(ch, faction, tostring(reputation))
        end
    end
    return reputation
end

function change_reputation(ch, factionvar, factionname, change)
    reputation = read_reputation(ch, factionvar)
    reputation = reputation + change
    chr_set_quest(ch, factionvar, tostring(reputation))
    if change > 0 then
        chr_create_text_particle(ch, factionname .. " reputation +".. change)
    else
        chr_create_text_particle(ch, factionname .. " reputation ".. change)
    end
end

function apply_amnesty(npc, ch, friendly_faction, friendly_faction_name,
                        foe_faction, foe_faction_name)
    local function say(message)
        npc_message(npc, ch, message)
    end

    local reputation = read_reputation(ch, friendly_faction)
    local foe_reputation = read_reputation(ch, foe_faction)

    local cost = - reputation -- TODO: formula
    say("You have to pay " .. cost .. " GP to make up for your crimes.")

    say("Do you accept?")
    local choices = { "Yes, here it is.",
                    "That's too much."}
    local res = npc_choice(npc, ch, choices)
    if res == 1 then
        local money = chr_money(ch)
        if money >= cost then
            chr_money_change(ch, -cost)
            change_reputation(ch, friendly_faction, friendly_faction_name, cost)
            -- TODO: formula
            change_reputation(ch, foe_faction, foe_faction_name, -cost)
            say("I hope you learned from your mistakes.")
        else
            say("Come back when you can afford it.")
        end
    else
        say("Mh. Come back when you changed your mind.")
    end
end
