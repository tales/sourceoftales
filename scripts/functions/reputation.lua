--[[

  Reputation related scripts

  Copyright (C) 2012 Jessica Tölke
  Copyright (C) 2013 Erik Schilling

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

function Entity:reputation(faction)
    assert(faction == "Soldier reputation" or faction == "Rebel reputation")

    return self:base_attribute(faction)
end

function Entity:change_reputation(faction, change)
    assert(faction == "Soldier reputation" or faction == "Rebel reputation")

    local current_reputation = self:reputation(faction)
    return self:set_base_attribute(faction, current_reputation + change)
end

function apply_amnesty(npc, ch, friendly_faction, foe_faction)

    local reputation = ch:reputation(friendly_faction)
    local foe_reputation = ch:reputation(foe_faction)

    local cost = - reputation -- TODO: formula
    say("You have to pay " .. cost .. " GP to make up for your crimes.")

    say("Do you accept?")
    local choices = { "Yes, here it is.",
                    "That's too much."}
    local res = ask(choices)
    if res == 1 then
        local money = ch:money()
        if money >= cost then
            ch:change_money(-cost)
            ch:change_reputation(friendly_faction, cost)
            -- TODO: formula
            ch:change_reputation(foe_faction, -cost)
            say("I hope you learned from your mistakes.")
        else
            say("Come back when you can afford it.")
        end
    else
        say("Mh. Come back when you changed your mind.")
    end
end
