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

local patrol = NPCPatrol:new("Rebel Philip")

local function rebel_talk(npc, ch)
    patrol:block(ch)

    local reputation = ch:reputation("Rebel reputation")

    if reputation >= REPUTATION_NEUTRAL then
        say("Henry is really inspiring. I was frustrated with the situation "
            .. "since a long while, but now Henry finally shows me a way to "
            .. "do something against the unjustice of the king and his "
            .. "followers.")
    elseif reputation > REPUTATION_RELUCTANT then
        say("You worked against us. Talk to Innkeeper Norman to settle "
            .. "this conflict.")
        ch:change_reputation("Rebel reputation", -1)
    else -- reputation <= REPUTATION_RELUCTANT
        say("Traitor!")
        ch:damage({
            base = 50,
            delta = 10,
            chance_to_hit = 9999
        })
    end
    patrol:unblock(ch)
end

local rebel = create_npc_by_name("Rebel Philip", rebel_talk)
rebel:set_base_attribute(16, 1)
patrol:assign_being(rebel)
schedule_every(23, function() patrol:logic() end)
