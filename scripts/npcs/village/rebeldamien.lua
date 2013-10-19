--[[

  Rebel Damien

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

local patrol = NPCPatrol:new("Rebel Damien")

local function rebel_talk(npc, ch)
    patrol:block(ch)

    local reputation = ch:reputation("Rebel reputation")

    if reputation >= REPUTATION_NEUTRAL then
        say("So you're joining us? The life as an outlaw isn't a piece of "
            .. "cake, so you better be sure.")
        say("But of course we're glad about every new member! So, welcome, "
            .. "I guess.")
    elseif reputation > REPUTATION_RELUCTANT then
        say("You worked against us. Talk to Innkeeper Norman to settle "
            .. "this conflict.")
        ch:change_reputation("Rebel reputation", -1)
    else -- reputation <= REPUTATION_RELUCTANT
        say("Traitor!")
        ch:damage(60, 10, 9999, DAMAGE_PHYSICAL, ELEMENT_NEUTRAL)
    end
    patrol:unblock(ch)
end

local rebel = create_npc_by_name("Rebel Damien", rebel_talk)
rebel:set_base_attribute(16, 2)
patrol:assign_being(rebel)
schedule_every(9, function() patrol:logic() end)
