--[[

  Rebel Philip

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

local function rebelTalk(npc, ch)
    local function say(message)
        npc_message(npc, ch, message)
    end

    local reputation = read_reputation(ch, "rebel_reputation")

    if reputation >= REPUTATION_NEUTRAL then
        say("Henry is really inspiring. I was frustrated with the situation since a long while, but now Henry finally "..
            "shows me a way to do something against the unjustice of the king and his followers.")
    elseif reputation > REPUTATION_RELUCTANT then
        say("You worked against us. Talk to Innkeeper Norman to settle this conflict.")
    else -- reputation <= REPUTATION_RELUCTANT
        say("Traitor!")
        being_damage(ch, 50, 10, 9999, DAMAGE_PHYSICAL, ELEMENT_NEUTRAL)
    end

end

local rebel = create_npc_by_name("Rebel Philip", rebelTalk)

being_set_base_attribute(rebel, 16, 1)
local patrol = Patrol:new("Rebel Philip")
patrol:assignBeing(rebel)
schedule_every(23, function() patrol:logic() end)
