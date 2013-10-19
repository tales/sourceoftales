--[[

  Rebel Tristan

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

local patrol = NPCPatrol:new("Rebel Tristan")

local function rebel_talk(npc, ch)
    patrol:block(ch)

    local reputation = ch:reputation("Rebel reputation")

    if reputation >= REPUTATION_NEUTRAL then
        say("Norman sent you, right? Did you know that he and Henry are very "
            .. "close to each other? Norman is like a father to him.")
        say("His real father was a soldier and spent most of his time far far "
            .. "away, while Henry's family lived here in Goldenfields "..
            "in poverty from the small pay his father got.")
        say("Henry spent a lot of time helping out at the inn, to earn some "
            .. "money. Norman always supported them.")
        say("Then his father went missing on a campaign, and the kingdom "
            .. "stopped to pay. Technically Henry's family had a right "..
            "for compensation money. The families of dead soldiers get that.")
        say("But the officials refused, because it's not proven that Henry's "
            .. "father is dead, he just got missing.")
        say("I think those experiences are a main reason why Henry is "
            .. "fighting against the kingdom.")
    elseif reputation > REPUTATION_RELUCTANT then
        say("You worked against us. Talk to Innkeeper Norman to settle "
            .. "this conflict.")
        ch:change_reputation("Rebel reputation", -1)
    else -- reputation <= REPUTATION_RELUCTANT
        say("Traitor!")
        ch:damage(70, 20, 9999, DAMAGE_PHYSICAL, ELEMENT_NEUTRAL)
    end
    patrol:unblock(ch)
end

local rebel = create_npc_by_name("Rebel Tristan", rebel_talk)
rebel:set_base_attribute(16, 3)
patrol:assign_being(rebel)
schedule_every(4, function() patrol:logic() end)
